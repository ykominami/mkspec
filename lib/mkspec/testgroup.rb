# frozen_string_literal: true

module Mkspec
  # The `TestGroup` class within the Mkspec module is designed to manage and organize test cases into groups.
  # It provides functionality to create a test group with a specific name and make argument basename, add test cases to the group,
  # and manage the overall collection of test cases within it. Each test group is identified by a unique name and can contain
  # multiple test cases, each represented by an instance of `TestCase`. This class is essential for structuring tests in a way
  # that they can be easily managed and executed as part of larger test suites or frameworks.
  #
  # @attr_reader name [String] The name of the test group, used for identification.
  # @attr_reader test_cases [Array<TestCase>] The collection of test cases added to the group.
  # @attr_reader size [Integer] The number of test cases within the group.
  # @attr_reader content_name_of_make_arg [String] The name used for generating make arguments, derived from the make argument basename and the group name.
  #
  # @example Creating a new TestGroup and adding a test case
  #   test_group = Mkspec::TestGroup.new("GroupName", "make_arg_basename")
  #   test_group.add_test_case("testcase_name", "dir", "test_1", "test_1_value", "test_1_message", "test_1_tag", "test_2", "test_2_value", "test_2_message", "test_2_tag")
  class TestGroup
    attr_reader :name, :test_cases, :size, :content_name_of_make_arg

    def initialize(name, make_arg_basename, extra = nil)
      raise MkspecAppError, "testgroup.rb 1 name.class=#{name.class}" unless Util.not_empty_string?(name).first

      @name = name
      @test_cases = []
      @size = 0
      @content_name_of_make_arg = [make_arg_basename, name].join('_')
      @extra = extra
    end

    def to_s
      @name
    end

    def add_test_case(testcase_name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value,
                      test_2_message, test_2_tag, extra = nil)
      v = TestCase.new(testcase_name, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value,
                       test_2_message, test_2_tag, extra)
      @size += 1
      @test_cases << v
      v
    end
  end
end
