# frozen_string_literal: true

module Erubyx
  class TestScriptGroup
    attr_reader :testscripts, :prefix_make_arg

    def initialize(tsv_path, start_char, limit, make_arg_basename)

      @tsv_path = tsv_path
      @name = start_char
      @limit = limit
      @make_arg_basename = make_arg_basename
      @testscripts = []
      @current_testscript = nil
      @default = {
        'test_1' => 'to',
        'test_1_value' => 'be_successfully_executed',
        'test_2' => 'not_to',
        'test_2_value' => 'have_output(/error:/)',
      }
      @current_testscript = make_testscript(@name)
    end

    def setup
      @data = File.readlines(@tsv_path).each_with_object({}) do |l, state|
        tgroup, tcase, test_1, test_1_value, test_2, test_2_value, extra = l.chomp.split(/\s+|\t+/)
        next if tgroup =~ /^\s*#/
        tgroup.tr!('-', '_')
        tgroup.tr!('.', '_')
        testgroup = (state[tgroup] ||= TestGroup.new(tgroup, @make_arg_basename))
        tcase.tr!('-', '_')
        tcase.tr!('.', '_')
        array = [test_1, test_1_value , test_2, test_2_value]
        test_1, test_1_value , test_2, test_2_value = array.map{|x|
          if x && x =~ /^\s*$/
            x = nil
          end
          x
        }

        test_1 = @default['test_1'] unless test_1
        test_1_value = @default['test_1_value'] unless test_1_value
        test_2 = @default['test_2'] unless test_2
        test_2_value = @default['test_2_value'] unless test_2_value
        Loggerxcm.debug_b{
          %W(
            test_1=#{test_1}
            test_1_value=#{test_1_value}
            test_2=#{test_2}
            test_2_value=#{test_2_value}
          )
        }
        testgroup.add_test_case( "#{testgroup}_#{tcase}", tcase, test_1, test_1_value, test_2, test_2_value, extra )
      end
      @data.each do |x|
        testgrop = x[1]
        # TestScriptは1個以上のTestGroupを含む。
        # TestGroupは1個以上のTestCaseを含む。
        # TestScriptに含まれるTestCaseの個数の上限が設定されている。
        # TestScriptに1個のTestGroupのみが存在する場合、TestCaseの総数が上限を超えていてもよい
        # (そうしなければ、上限を超えたTestCaseが含むTestGroupを、TestScriptが持つことができない)
        if @current_testscript.grouping(testgrop) != :NOT_EMPTY
          @current_testscript = make_testscript(next_name)
          @current_testscript.grouping(testgrop)
        end
      end
    end

    def make_testscript(name)
      ts = TestScript.new(name, @limit)
      @testscripts << ts
      ts
    end

    def next_name
      @name = @name.succ
    end

    def result
      @testscripts
    end

    def listup_testscripts
      @testscripts.map { |x| x.print }
    end
  end
end
