# frozen_string_literal: true

module Erubyx
  class TestScript
    attr_reader :name, :script_name, :test_groups

    def initialize(name, limit)
      @name = name
      @script_name = %(#{name}_spec.rb)
      @limit = limit
      @test_groups = []
      @total_test_cases = 0
    end

    def print
      puts %(#{@script_name} #{@test_groups.size})
      @test_groups.map(&:print)
    end

    def grouping(tag)
      result = :CONTINUE
      if @total_test_cases < @limit
        next_size = @total_test_cases + tag.size
        if next_size <= @limit
          @test_groups << tag
          @total_test_cases = next_size
        else
          inner_distance = (@limit - @total_test_cases)
          outer_distance = (next_size - @limit)
          if inner_distance >= outer_distance
            @test_groups << tag
            @total_test_cases = next_size
          else
            result = :NEW
          end
        end
      else
        result = :NEW
      end
      result
    end
  end
end
