# frozen_string_literal: true

module Mkspec
  # The `TestCase` class represents a single test case within the Mkspec framework.
  # It encapsulates all the necessary details for executing a test case, including
  # test identifiers, directory paths, test conditions, expected values, messages,
  # tags, and any additional information required for the test execution.
  #
  # @attr_reader name [String] The name of the test case.
  # @attr_reader dir [String] The directory where the test case is located.
  # @attr_reader test_1 [Symbol] The first test condition identifier.
  # @attr_reader test_1_value [Object] The expected value for the first test condition.
  # @attr_reader test_1_message [String] The message associated with the first test condition.
  # @attr_reader test_1_tag [Symbol] A tag categorizing the first test condition.
  # @attr_reader test_2 [Symbol] The second test condition identifier.
  # @attr_reader test_2_value [Object] The expected value for the second test condition.
  # @attr_reader test_2_message [String] The message associated with the second test condition.
  # @attr_reader test_2_tag [Symbol] A tag categorizing the second test condition.
  # @attr_reader extra [Object, nil] Additional information or parameters related to the test case.
  #
  # @example Creating a new TestCase instance
  #   testcase = Mkspec::TestCase.new("test_case_name", "/path/to/dir", :test_1, "expected_value_1",
  #                                   "Test 1 message", :tag1, :test_2, "expected_value_2",
  #                                   "Test 2 message", :tag2, "Extra info")
  class TestCase
    attr_reader :name, :dir, :test_1, :test_1_value, :test_1_message, :test_1_tag, :test_2, :test_2_value,
                :test_2_message, :test_2_tag, :extra

    def initialize(name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message,
                   test_2_tag, extra = nil)
      raise MkspecAppError, "testcase.rb 1 name.class=#{name.class}" unless Util.not_empty_string?(name).first

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
