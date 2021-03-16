# frozen_string_literal: true

module Erubyx
  class TestCase < Objectx
    attr_reader :name, :dir, :test_1, :test_2, :extra

    def initialize(test_group, name, dir, test_1, test_2, extra = nil)
      super()

      @test_group = test_group
      @name = name
      @dir = dir
      @test_1 = test_1
      @test_2 = test_2
      @extra = extra
    end

    def print
      @_log.debug "testcase=#{@name}"
    end
  end
end
