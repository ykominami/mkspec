# frozen_string_literal: true

module Erubyx
  class Templatex < Objectx
    def initialize(setting)
      super()

      @setting = setting
      @template_path = @setting.template_path
      pn = Pathname.new(@template_path)
      pn.parent.mkdir unless pn.parent.exist?
      @content = ''
      @func_name_of_make_arg = @setting.func_name_of_make_arg
    end

    def make_line_1(name)
      %(  <%= #{name} %>)
    end

    def make_line_2(name)
      %(    <%= #{name} %>)
    end

    def setup
      lines = []
      str = %(
require 'pathname'

RSpec.describe '<%= desc %>', type: :aruba do
  <%= rspec_describe_head %>
)
      lines << str

      @setting.testscript.test_groups.each do |test_group|
        lines << make_line_1(test_group.name)
        lines << make_line_2(test_group.content_name_of_make_arg)
        test_group.test_cases.each do |test_case|
          lines << make_line_2(test_case.extra) if test_case.extra
          lines << make_line_2(test_case.name)
        end
      end
      str_end = '
  <%= rspec_describe_context_end %>
end
'
      lines << str_end

      @content = lines.join("\n")
    end

    def output
      File.open(@template_path, 'w') do |file|
        file.write(@content)
      end
    end
  end
end
