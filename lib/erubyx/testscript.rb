# frozen_string_literal: true

module Erubyx
  class TestScript
    attr_reader :name, :script_name, :test_groups, :total_test_cases, :inner_result

    def initialize(name, limit)
      @name = name
      @script_name = %(#{name}_spec.rb)
      @limit = limit
      @test_groups = []
      @total_test_cases = 0
    end

    def print
      Loggerxcm.debug %(#{@script_name} #{@test_groups.size})
      @test_groups.map(&:print)
    end

    def grouping(testgroup)
      # TestScriptは1個以上のTestGroupを含む。
      # TestGroupは1個以上のTestCaseを含む。
      # TestScriptに含まれるTestCaseの個数の上限が設定されている。
      # TestScriptに1個のTestGroupのみが存在する場合、TestCaseの総数が上限を超えていてもよい
      # (そうしなければ、上限を超えたTestCaseが含むTestGroupを、TestScriptが持つことができない)
      result = :NOT_EMPTY
      @inner_result = :NOT_EMPTY_1
      if @total_test_cases < @limit
        next_size = @total_test_cases + testgroup.size
        if next_size <= @limit
          @test_groups << testgroup
          @total_test_cases = next_size
          result = :NOT_EMPTY
          @inner_result = :NOT_EMPTY_2
        else
          inner_distance = (@limit - @total_test_cases)
          outer_distance = (next_size - @limit)
          if inner_distance >= outer_distance
            @test_groups << testgroup
            @total_test_cases = next_size
            result = :NOT_EMPTY
            @inner_result = :NOT_EMPTY_3
          else
            if @test_groups.empty?
              @test_groups << testgroup
              @total_test_cases = next_size
            end
            result = :EMPTY
            @inner_result = :EMPTY_1
          end
        end
      else
        if @test_groups.empty?
          @test_groups << testgroup
          @total_test_cases = next_size
        end
        result = :EMPTY
        @inner_result = :EMPTY_2
      end
      result
    end
  end
end
