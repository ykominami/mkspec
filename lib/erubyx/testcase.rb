# frozen_string_literal: true

module Erubyx
  class TestCase
    attr_reader :name, :dir, :test_1, :test_1_value, :test_2, :test_2_value, :extra

    def initialize(test_group, name, dir, test_1, test_1_value, test_2, test_2_value, extra = nil)
      @test_group = test_group
      raise unless name.instance_of?(String)
      @name = name
      @dir = dir
      @test_1 = test_1
      @test_1_value = test_1_value
      @test_2 = test_2
      @test_2_value = test_2_value
      @extra = extra
    end

    def print
      Loggerxcm.debug "testcase=#{@name}"
    end
  end
end
