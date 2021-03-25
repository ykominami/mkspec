# frozen_string_literal: true

module Mkspec
  class Item
    attr_reader :state, :content_lines, :content_path, :name, :outer_hash, :tag_table,
                :extract_count, :local_hash, :yaml_path

    INDENT_UNIT_SIZE = 2

    def initialize(indent_level, extra_indent, name, outer_hash, content_path, yaml_path, config)
      @indent_level = indent_level
      @extra_indent = extra_indent
      @name = name
      @outer_hash = outer_hash
      @local_hash = {}
      Mkspec::Loggerxcm.debug("-1 content_path=#{content_path}|")
      if content_path.nil?
        Mkspec::Loggerxcm.debug("0 content_path=#{content_path}|")
        @content_pn = nil
        raise
      else
        Mkspec::Loggerxcm.debug("1 content_path=#{content_path}|")
        pn = Pathname.new(content_path)
        if pn.exist?
          @content_pn = pn
          Mkspec::Loggerxcm.debug("2 @content_pn=#{@content_pn}|")
        else
          @content_pn = config.make_path_under_template_and_data_dir(pn)
          if @content_pn.exist? == false
            Mkspec::Loggerxcm.debug("3 @content_pn=#{@content_pn}|")
            @content_pn = nil
            raise
          end
        end
      end
      if yaml_path
        pn_2 = Pathname.new(yaml_path)
        if pn_2.exist?
          @yaml_pn = pn_2
        else
          @yaml_pn = config.make_path_under_template_and_data_dir(pn_2)
          @yaml_pn = nil unless @yaml_pn.exist?
        end
      else
        @yaml_pn = nil
      end

      @config = config
      @re = Regexp.new("^(\s*)<%=(.+)%>")
      @children = {}
      Loggerxcm.debug("@yaml_pn=#{@yaml_pn}")
      Loggerxcm.debug("@content_pn=#{@content_pn}")
      @extracted = nil
      @extract_count = 0
      setup
    end

    def setup
      # @local_hash = YAML.load_file(@yaml_pn) if @yaml_pn && @yaml_pn.exist?
      @local_hash = YAML.load_file(@yaml_pn) if @yaml_pn&.exist?
      raise if @content_pn.nil? || !@content_pn.exist?
      @content_lines = File.readlines(@content_pn).map(&:chomp)
      @tag_table = analyze(@content_lines)
      @hash = @local_hash.size.positive? ? @local_hash : @outer_hash
      @children = make_children(@tag_table, @hash)
      error_count = 0
      @children.each do |k, v|
        @hash[k] = v.result
        return less STATE.success?
      end
    end

    def result
      Loggerxcm.debug(%(################################## @content_pn=#{@content_pn}))
      raise unless @content_pn&.exist?

      add_indent(@hash)
      content = @content_lines.join("\n")
      replace_tag(content, @hash)
      @extracted
    end

    def add_indent(hash)
      indent = @indent_level * INDENT_UNIT_SIZE + @extra_indent

      hash.keys do |key|
        content_lines = []
        lines = hash[key].split("\n")
        content_lines << lines[0]
        content_lines += lines[1, lines.size].map do |l|
          if l.size.positiv?
            indent + l
          else
            ""
          end
        end
        hash[key] = content_lines.join("\n")
      end
    end

    def analyze(content_lines)
      content_lines.each_with_object({}) do |l, state|
        next unless @re.match(l)

        space = Regexp.last_match[1]
        key = Regexp.last_match[2].strip
        state[key] = space.size
      end
    end

    def make_children(tag_table, hash)
      children = {}
      tag_table.each do |tag, extra_indent|
        Mkspec::Loggerxcm.debug("-Y tag=#{tag}|")
        case hash[tag].class
        when ::Hash
          hs = @hash[tag]
          content_path = hs["path"]
          yaml_path = hs["setting_path"]
          Mkspec::Loggerxcm.debug("-X hs.class=#{hs.class}|")
          Mkspec::Loggerxcm.debug("-X hs=#{hs}|")
          children[tag] = Item.new(@indent_level + 1, extra_indent, tag, hs, content_path, yaml_path, @config)
        when ::String
          Mkspec::Loggerxcm.debug("-V Sring hash[#{tag}]=#{hash[tag]}|")
        else
          Mkspec::Loggerxcm.debug("-W else class hash[#{tag}].class=#{hash[tag].class}|")
        end
      end
      children
    end

    def replace_tag(content, hash)
      eruby = PrefixedLineEruby.new(content)
      begin
        @extracted = eruby.result(hash)
        return unless STATE.success?
        @extract_count += 1
      rescue StandardError => e
        message = %W[
          "3 Item.to_s"
          #{e.to_s}
          "@content=#{@content_pn}"
          "content=#{content}"
        ]
        Loggerxcm.error_b do
          #{message}
        end
        binding.pry
        STATE.change(CANNOT_WRITE_YAML_FILE, message)
      end
      @extracted
    end
  end
end
