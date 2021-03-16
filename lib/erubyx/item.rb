# frozen_string_literal: true

module Erubyx
  class Item
    def initialize(level, tag, path, hash, config)

      @level = level
      @tag = tag
      @path = Pathname.new(path)
      @hash = hash
      @config = config
      @pn = if @path.exist?
              @path
            else
              config.make_path_under_template_and_data_dir(@path)
            end
      @re = Regexp.new("^(\s*)<%=(.+)%>")
      @extracted = nil
      @extract_count = 0
      @content_lines = []
      @space_hash = {}
      @tag_table = {}
    end

    def analyze(content)
      content.each_with_object({}) do |l, state|
        next unless @re.match(l)

        space = Regexp.last_match[1]
        key = Regexp.last_match[2].strip
        state[key] = space.size
      end
    end

    def load
      @content_lines = File.readlines(@pn)
      @tag_table = analyze(@content_lines)
    end

    def result
      to_s if @extract_count.zero?
      @extracted
    end

    def to_s
      key, size = @tag_table[@tag]
      if @hash[key] && size.zero?
        indent = (@space_hash[size] ||= ' ' * size)
        content = @content_lines.each_with_object([0, []]) do |l, state|
          state[1] << (indent + l) if state[0].positive?
          state[0] += 1
        end
      else
        content = @content_lines.join
      end
      eruby = PrefixedLineEruby.new(content)
      Loggerxcm.debug_b {
        [ "----",
        "content=#{content}",
        "---- END",
        "@hash=#{@hash}",
        "---- END END"]
      }
      @extract_count += 1
      Loggerxcm.debug_b {
        [ "@hash.class=#{@hash.class}",
        %(Item to_s hash['func_name']=|#{@hash['func_name']}|),
        %(Item to_s hash['make_arg']=|#{@hash['make_arg']}|),
        ]
      }
#=begin
      @hash.map{|k,v|
        Loggerxcm.debug("k=#{k}")
        if v.instance_of?(Hash)
          v.map { |k2,v2|
            Loggerxcm.debug("  k2=#{k2}")
          }
        else
          Loggerxcm.debug("v=#{v}")
        end
      }
#=end
      begin
        @extracted = eruby.result(@hash)
      rescue => err
        Loggerxcm.debug_b {
          ["3 Item.to_s",
           err.to_s,
           "@path=#{@path}",
           "content=#{content}"
          ]
        }
      end
    end
  end
end
