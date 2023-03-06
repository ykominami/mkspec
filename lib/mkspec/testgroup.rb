# frozen_string_literal: true

module Mkspec
  class TestGroup
    attr_reader :name, :test_cases, :size, :content_name_of_make_arg

    def initialize(name, make_arg_basename, extra = nil)
      raise MkspecAppError.new("testgroup.rb 1 name.class=#{name.class}") unless Util.not_empty_string?(name).first

      @name = name
      @test_cases = []
      @size = 0
      @content_name_of_make_arg = [make_arg_basename, name].join('_')
      @extra = extra
    end

    def to_s
      @name
    end

    def add_test_case(testcase_name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value,
                      test_2_message, test_2_tag, extra = nil)
      v = TestCase.new(testcase_name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value,
                       test_2_message, test_2_tag, extra)
      @size += 1
      @test_cases << v
      v
    end
  end
end
