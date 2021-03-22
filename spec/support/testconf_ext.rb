# frozen_string_literal: true

module TestConf
  require 'pathname'
  require 'ostruct'
  require 'clitest'

  class TestConf
    def add_testcases(tg, count)
      testcase_name = 'a_b'
      dir = '1'
      test_1 = 'to'
      test_1_value = 'xyz'
      test_2 = 'to_not'
      test_2_value = 'abc'
      extra = nil
      count.downto(1) do |n| 
        tg.add_test_case(testcase_name, dir, test_1, test_1_value, test_2, test_2_value, extra)
      end
    end

    def add_testcase_2(tg)
      testcase_name = 'a_b'
      dir = '2'
      test_1 = 'to'
      test_1_value = 'xyz'
      test_2 = 'to_not'
      test_2_value = 'abc'
      extra = nil
      ret = tg.add_test_case(testcase_name, dir, test_1, test_1_value, test_2, test_2_value, extra)
    end
  end
end