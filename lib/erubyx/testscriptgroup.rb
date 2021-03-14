# frozen_string_literal: true

module Erubyx
  class TestScriptGroup
    attr_reader :testscripts

    def initialize(tsv_path, start_char, limit, make_arg)
      @tsv_path = tsv_path
      @name = start_char
      @limit = limit
      @make_arg = make_arg
      @testscripts = []
      @default = { 'test_1' => 'to', 'test_2' => 'not_to' }
      make_testscript(@name)
    end

    def setup
      @data = File.readlines(@tsv_path).each_with_object({}) do |l, state|
        tgroup, tcase, test_1, test_2, extra = l.chomp.split(/\s+|\t+/)
        tgroup.tr!('-', '_')
        tgroup.tr!('.', '_')
        tg = (state[tgroup] ||= TestGroup.new(tgroup, @make_arg))
        tcase.tr!('-', '_')
        tcase.tr!('.', '_')
        test_1 = @default['test_1'] unless test_1
        test_2 = @default['test_2'] unless test_2
        tg.add_test_case(%(#{tg}_#{tcase}), tcase, test_1, test_2, extra)
      end
      @data.each do |x|
        tag = x[1]

        result = @testscript.grouping(tag)
        if result != :CONTINUE
          make_testscript(next_name)
          @testscript.grouping(tag)
        end
      end
    end

    def make_testscript(name)
      @testscript = TestScript.new(name, @limit)
      @testscripts << @testscript
    end

    def next_name
      @name = @name.succ
    end

    def result
      @testscripts
    end

    def listup_testscripts
      @testscripts.map { |x| puts x.print }
    end
  end
end
