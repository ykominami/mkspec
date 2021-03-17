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
      if @total_test_cases < @limit
        next_size = @total_test_cases + testgroup.size
        if next_size <= @limit
          @test_groups << testgroup
          @total_test_cases = next_size
        else
          inner_distance = (@limit - @total_test_cases)
          outer_distance = (next_size - @limit)
          if inner_distance >= outer_distance
            @test_groups << testgroup
            @total_test_cases = next_size
          else
            result = :EMPTY
          end
        end
      else
        result = :EMPTY
      end
      result
    end
  end
end
