# frozen_string_literal: true

module Erubyx
  class TestCase
    attr_reader :name, :dir, :test_1, :test_2, :extra

    def initialize(test_group, name, dir, test_1, test_2, extra = nil)

      @test_group = test_group
      @name = name
      @dir = dir
      @test_1 = test_1
      @test_2 = test_2
      @extra = extra
    end

    def print
      Loggerxcm.debug "testcase=#{@name}"
    end
  end
end
