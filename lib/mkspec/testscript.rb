# frozen_string_literal: true

module Mkspec
  # The `TestScript` class represents a script composed of multiple test groups within the Mkspec framework.
  # It manages the organization and execution of these groups, ensuring that the total number of test cases
  # does not exceed a predefined limit. This class is crucial for maintaining the structure and constraints
  # of test execution within the framework.
  #
  # @attr_reader name [String] The name of the test script.
  # @attr_reader script_name [String] The filename of the test script, generated based on its name.
  # @attr_reader test_groups [Array<TestGroup>] The collection of test groups within the script.
  # @attr_reader total_test_cases [Integer] The total number of test cases across all groups in the script.
  # @attr_reader inner_result [Symbol] The result of the last grouping operation, indicating success or failure.
  #
  # @example Creating a new TestScript instance with a limit on the total number of test cases
  #   test_script = Mkspec::TestScript.new("example_script", 50)
  #
  # @param name [String] The name of the test script.
  # @param limit [Integer] The maximum allowed number of test cases within the script.
  class TestScript
    attr_reader :name, :script_name, :test_groups, :total_test_cases, :inner_result

    def initialize(name, limit)
      raise MkspecAppError, "testscript.rb 1 name.class=#{name.class}" unless Util.not_empty_string?(name).first

      @name = name
      @script_name = Util.make_spec_filename(name)
      @limit = limit
      @test_groups = []
      @total_test_cases = 0
    end

    # Adds a test group to the script if doing so does not exceed the limit on the total number of test cases.
    # This method implements logic to decide whether to add the group based on the current total of test cases,
    # the size of the group being added, and the limit. It prioritizes adding groups that keep the total under
    # the limit but allows for exceptions in certain conditions.
    #
    # @param testgroup [TestGroup] The test group to be added to the script.
    # @return [Symbol] A symbol indicating the result of the attempt to add the group (:NOT_EMPTY or :EMPTY).
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
