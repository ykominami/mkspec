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
              config.make_path_under_template_and_data_dir( @path )
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
        end[1].join
      else
        content = @content_lines.join
      end
      eruby = PrefixedLineEruby.new(content)
      @extract_count += 1
      @extracted = eruby.result(@hash)
    end
  end
end
