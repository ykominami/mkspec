module Erubyx
  class Item
    attr_reader :state, :content_lines, :content_path, :name, :outer_hash, :tag_table,
    :extract_count

#    def initialize(     tag,              path, hash, config)
    INDENT_UNIT_SIZE = 2

    def initialize(indent_level, extra_indent, name, outer_hash, content_path, yaml_path, config)
      @indent_level = indent_level
      @extra_indent = extra_indent
      @name = name
      @outer_hash = outer_hash
      @local_hash = {}
      Erubyx::Loggerxcm.debug("-1 content_path=#{content_path}|")
      if content_path != nil
        Erubyx::Loggerxcm.debug("0 content_path=#{content_path}|")
        pn = Pathname.new(content_path)
        if pn.exist?
          @content_pn = pn
          Erubyx::Loggerxcm.debug("1 @content_pn=#{@content_pn}|")
        else
          @content_pn = config.make_path_under_template_and_data_dir(pn)
          if @content_pn.exist? == false
            Erubyx::Loggerxcm.debug("2 @content_pn=#{@content_pn}|")
            @content_pn = nil
            raise
          end
        end
      else
        Erubyx::Loggerxcm.debug("3 content_path=#{content_path}|")
        @content_pn = nil
        raise
      end
      if yaml_path
        pn2= Pathname.new(yaml_path)
        if pn2.exist?
          @yaml_pn = pn2
        else
          @yaml_pn = config.make_path_under_template_and_data_dir(pn2)
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
      Erubyx::Loggerxcm.debug("@yaml_pn=#{@yaml_pn}")
      Erubyx::Loggerxcm.debug("@content_pn=#{@content_pn}")
      Erubyx::Loggerxcm.debug("@outer_hash=#{@outer_hash}")
      if @yaml_pn
        @local_hash = YAML.load_file(@yaml_pn)
      end
      raise unless @content_pn
      @content_lines = File.readlines(@content_pn).map{|l| l.chomp}
      #Loggerxcm.debug("@content_lines=#{@content_lines}")
      @tag_table = analyze(@content_lines)
      @hash = @local_hash.size > 0 ? @local_hash : outer_hash
      @children = make_children(@tag_table, @hash)
      @children.each do |k,v|
        @hash[k] = v.result
      end
    end

    def result
      raise unless @content_pn
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
        content_lines += lines[1,lines.size].map{|l|
          if l.size > 0
            indent + l
          else
            ''
          end
        }
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
      tag_table.each{|tag, extra_indent|
        Erubyx::Loggerxcm.debug("-Y tag=#{tag}|") 
        case hash[tag].class
        when  ::Hash
          #Loggerxcm.debug("tag=#{tag}")
          #Loggerxcm.debug("hs=#{hs}")
          #content_path = hs['content_path']
          hs = @hash[tag]
          content_path = hs['path']
          yaml_path = hs['setting_path']
          Erubyx::Loggerxcm.debug("-X hs.class=#{hs.class}|")
          Erubyx::Loggerxcm.debug("-X hs=#{hs}|")
          #yaml_path = nil
          children[tag] = Item.new(@indent_level + 1, extra_indent, tag, hs, content_path, yaml_path, @config)
        when ::String
          # do nothing
          Erubyx::Loggerxcm.debug("-V Sring hash[#{tag}]=#{hash[tag]}|")
        else
          # do nothing
          Erubyx::Loggerxcm.debug("-W else class hash[#{tag}].class=#{hash[tag].class}|")
        end
      }
      children
    end

    def replace_tag(content, hash)
      eruby = PrefixedLineEruby.new(content)
      @state = :G
      Loggerxcm.debug_b {
        [ "----",
        "content=#{content}",
        "---- END",
        "hash=#{hash}",
        "---- END END"]
      }
      # print_hash
      begin
        @extracted = eruby.result(hash)
        @state = :H
        @extract_count += 1
      rescue => err
        Loggerxcm.debug_b {
          ["3 Item.to_s",
          err.to_s,
          "@content=#{@content_pn}",
          "content=#{content}"
          ]
        }
      end
      # print_hash_2
      @extracted
    end

  end
end
