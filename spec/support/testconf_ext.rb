# frozen_string_literal: true

module Mkspec
  require 'pathname'
  require 'ostruct'
  require 'clitest'

  class TestConf
    def add_testcases(tg, count)
      testcase_name = 'a_b'
      dir = '1'
      test_1 = 'to'
      test_1_value = 'xyz'
      test_1_message = ''
      test_1_tag = ''
      test_2 = 'to_not'
      test_2_value = 'abc'
      test_2_message = ''
      test_2_tag = ''
      extra = nil
      count.downto(1) do |n|
        tg.add_test_case(testcase_name, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra = nil)
      end
    end

    def add_testcase_2(tg)
      testcase_name = 'a_b'
      dir = '2'
      test_1 = 'to'
      test_1_value = 'xyz'
      test_1_message = ''
      test_1_tag = ''
      test_2 = 'to_not'
      test_2_value = 'abc'
      test_2_message = ''
      test_2_tag = ''
      extra = nil
      tg.add_test_case(testcase_name, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra = nil)
    end
  end
end