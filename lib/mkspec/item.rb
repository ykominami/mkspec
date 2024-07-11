# frozen_string_literal: true

require 'pathname'

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
      raise Mkspec::MkspecDebugError, "item.rb initialize 1" unless Util.validate_hash(@outer_hash, "top_dir", String)

      @local_hash = {}
      @config = config
      content_path_full = @config.archive_dir_pn.join(content_path)
      Util.dump_var(:yaml_path, yaml_path)
      Util.dump_var(:content_path_full, content_path_full)
      @yaml_pn, kind_1 = ensure_path(yaml_path.to_s)
      @content_pn, kind_2 = ensure_path(content_path_full.to_s)
      Util.dump_var(:@yaml_pn, @yaml_pn)
      Util.dump_var(:kind_1, kind_1)
      Util.dump_var(:@content_pn, @content_pn)
      Util.dump_var(:kind_2, kind_2)
      raise Mkspec::MkspecDebugError, "item.rb 2 content_path_full=#{content_path_full}" unless @content_pn

      @children = {}
      Loggerxcm.debug("Item.new @yaml_pn=#{@yaml_pn}")
      Loggerxcm.debug("Item.new @content_pn=#{@content_pn}")
      @extracted = nil
      @extract_count = 0
      prepare
    end

    def ensure_path(path)
      pn = nil
      kind = nil
      if Util.not_empty_string?(path).first
        pn = Pathname.new(path)
        kind = 1
        unless pn.exist?
          pn = @config.make_path_under_template_and_data_dir(pn)
          kind = 2
          unless pn.exist?
            pn = nil
            kind = 3
          end
        end
      else
        pn = nil
        kind = 4
      end
      [pn, kind]
    end

    def prepare
      Loggerxcm.debug("Item#setup @yaml_pn=#{@yaml_pn}")
      Loggerxcm.debug("Item#setup @content_pn=#{@content_pn}")
      @local_hash = Util.extract_in_yaml_file(@yaml_pn) if @yaml_pn&.exist?
      raise Mkspec::MkspecDebugError, "item.rb prepare 1" unless Util.validate_hash(@local_hash, "top_dir", String)
      raise MkspecAppError, "item.rb 4" unless Util.valid_pathname?(@content_pn)

      @content_lines = Util.get_file_content_lines(@content_pn)
      raise MkspecAppError, "item.rb 5" unless Util.valid_array?(@content_lines)

      @tag_table = Util.analyze(@content_lines)
      if @local_hash.size.positive?
        Loggerxcm.debug("Item#setup use @local_hash")
        @hash = @local_hash
        #raise Mkspec::MkspecDebugError,.new("item.rb prepare 1 use @local_hash")
      else
        Loggerxcm.debug("Item#setup use @outer_hash")
        @hash = @outer_hash
      end
      @children = make_children(@tag_table, @hash)
      @children.each do |k, v|
        @hash[k] = v.result
        raise MkspecAppError.new("item.rb 10 ", STATE.message_array) unless STATE.success?
      end
    end

    def check_kind_of_hash
      h = if @hash == @logcal_hash
            "local_hash"
          else
            "outer_hash"
          end
      Loggerxcm.debug("Item#result ## item.result h=#{h}")
    end

    def result
      Loggerxcm.debug(%(################################## Item#result @content_pn=#{@content_pn}))
      raise MkspecAppError, "item.rb 5 Item#result @content_pn=#{@content_pn}" unless @content_pn&.exist?

      check_kind_of_hash
      content = @content_lines.join("\n")
      @extracted = Util.extract_with_eruby(content, @hash)
      # replace_tag(content, @hash)
    end

    def add_indent(hash)
      indent = (@indent_level * INDENT_UNIT_SIZE) + @extra_indent

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
          Loggerxcm.debug("Item#make_chldren content_path=#{content_path} yaml_path=#{yaml_path}")
          children[tag] = Item.new(@indent_level + 1, extra_indent, tag, hs, content_path, yaml_path, @config)
        when ::String
          Mkspec::Loggerxcm.debug("-V Sring hash[#{tag}]=#{hash[tag]}|")
        else
          Mkspec::Loggerxcm.debug("-W else class hash[#{tag}].class=#{hash[tag].class}|")
        end
      end
      children
    end
  end
end
