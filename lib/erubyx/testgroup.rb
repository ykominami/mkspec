# frozen_string_literal: true

module Erubyx
  class TestGroup < Objectx
    attr_reader :name, :test_cases, :size, :content_name_of_make_arg

    def initialize(name, make_arg_basename, extra = nil)
      super()

      @name = name
      @test_cases = []
      @size = 0
      @content_name_of_make_arg = [make_arg_basename, name].join('_')
      @extra = extra
    end

    def to_s
      @name
    end

    def add_test_case(testcase_name, dir, test_1, test_2, extra = nil)
      @test_cases << TestCase.new(self, testcase_name, dir, test_1, test_2, extra)
      @size += 1
    end

    def print
      @_log.debug '# TestGroup'
      @_log.debug @name
      @test_cases.map(&:print)
    end
  end
end
