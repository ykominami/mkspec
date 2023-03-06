# frozen_string_literal: true

module Mkspec
  class TestCase
    attr_reader :name, :dir, :test_1, :test_1_value, :test_1_message, :test_1_tag, :test_2, :test_2_value,
                :test_2_message, :test_2_tag, :extra

    def initialize(name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message,
                   test_2_tag, extra = nil)
      raise MkspecAppError.new("testcase.rb 1 name.class=#{name.class}" ) unless Util.not_empty_string?(name).first

      @name = name
      @dir = dir
      @test_1 = test_1
      @test_1_value = test_1_value
      @test_1_message = test_1_message
      @test_1_tag = test_1_tag
      @test_2 = test_2
      @test_2_value = test_2_value
      @test_2_message = test_2_message
      @test_2_tag = test_2_tag
      @extra = extra
    end
  end
end
