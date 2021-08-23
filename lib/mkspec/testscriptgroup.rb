# frozen_string_literal: true

module Mkspec
  class TestScriptGroup
    attr_reader :testscripts, :name

    #                 test_1 test_1_value                test_1_message,         test_1_tag,            test_2    test_2_value             test_2_message                test_2_tag
    DEFAULT_VALUES = ['to',  'be_successfully_executed', 'execute successfully', 'test_normal_sh:true', 'not_to', 'have_output(/error:/)', "don't have error in output", 'test_normal_sh_out:true'].freeze

    def initialize(tsv_path, start_char, limit, make_arg_basename)
      @tsv_path = tsv_path
      raise( MkspecAppError, "testscriptgroup.rb 1 start_char.class=#{start_char.class}") unless Util.not_empty_string?(start_char).first
      @name = start_char
      @limit = limit
      @make_arg_basename = make_arg_basename
      @testscripts = []
      @current_testscript = make_testscript(@name)
    end

    def setup_test_group(l, state)
      # tgroup, tcase, tmp = l.chomp.split(/\s+|\t+/)
      tgroup, tcase, *tmp = l.chomp.split("\t")
      raise( MkspecAppError, "testscriptgroup.rb 2 tgroup=#{tgroup}") if tgroup.nil?

      Loggerxcm.debug("tgroup=#{tgroup}|")
      raise(MkspecAppError, "testscriptgroup.rb 3") if tgroup =~ /^\s*#/

      raise(MkspecAppError, "testscriptgroup.rb 4") if tcase.nil?

      raise(MkspecAppError, "testscriptgroup.rb 5") if tcase =~ /^\s*#/

      raise(MkspecAppError, "testscriptgroup.rb 6") if tmp.size > 4

      Util.check_numeric_and_raise(tmp, 0 , MkspecAppError)

      Util.check_numeric_and_raise(tmp, 1 , MkspecAppError)

      Util.check_numeric_and_raise(tmp, 2 , MkspecAppError)

      Util.check_numeric_and_raise(tmp, 3 , MkspecAppError)

      Util.check_numeric_and_raise(tmp, 4 , MkspecAppError)

      Util.check_numeric_and_raise(tmp, 5 , MkspecAppError)

      Util.check_numeric_and_raise(tmp, 6 , MkspecAppError)

      Util.check_numeric_and_raise(tmp, 7 , MkspecAppError)
      # Loggerxcm.debug("tmp=#{tmp}")
      tgroup = tgroup.tr('-', '_').tr('.', '_')
      testgroup = (state[tgroup] ||= TestGroup.new(tgroup, @make_arg_basename))
      tcase = tcase.tr('-', '_').tr('.', '_')
      array = DEFAULT_VALUES.zip(tmp[0, 8]).map { |lh, rh| rh.nil? ? lh : rh }
      extra = tmp[4, tmp.size]
      # Loggerxcm.debug("array=#{array}")
      test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag = array
      testgroup.add_test_case("#{testgroup}_#{tcase}", tcase, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra)
      self
    end

    def setup_from_tsv
      File.readlines(@tsv_path).each_with_object({}) do |l, state|
        next if l =~ /^\s*#/
        next if l =~ /^\s*$/
        setup_test_group(l, state)
      end
    end

    def setup
      @data = setup_from_tsv
      @data.each do |x|
        testgroup = x[1]
        # TestScriptは1個以上のTestGroupを含む。
        # TestGroupは1個以上のTestCaseを含む。
        # TestScriptに含まれるTestCaseの個数の上限が設定されている。
        # TestScriptに1個のTestGroupのみが存在する場合、TestCaseの総数が上限を超えていてもよい
        # (そうしなければ、上限を超えたTestCaseが含むTestGroupを、TestScriptが持つことができない)
        if @current_testscript.grouping(testgroup) != :NOT_EMPTY
          @current_testscript = make_testscript(next_name)
          @current_testscript.grouping(testgroup)
        end
      end
      self
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
  end
end
