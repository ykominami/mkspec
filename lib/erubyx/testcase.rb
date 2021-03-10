# frozen_string_literal: true
module Erubyx
  class TestCase
    attr_reader :name, :dir, :make_arg, :test_1, :test_2, :extra

    def initialize(test_group, name, dir, make_arg, test_1, test_2, extra = nil)
      @test_group = test_group
      @name = name
      @dir = dir
      @make_arg = make_arg
      @test_1 = test_1
      @test_2 = test_2
      @extra = extra
    end

    def print
      puts "testcase=#{@name}"
    end
  end
end
