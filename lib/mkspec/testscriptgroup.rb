# frozen_string_literal: true

module Mkspec
  # The `TestScriptGroup` class is responsible for managing a collection of `TestScript` instances.
  # It facilitates the organization and execution of test scripts based on a set of criteria defined
  # by the user, such as a limit on the number of test cases per script or specific naming conventions.
  # This class plays a crucial role in structuring tests in a scalable and manageable way, especially
  # when dealing with large numbers of tests that need to be divided into smaller, more manageable units.
  #
  # @attr_reader testscripts [Array<TestScript>] The collection of test scripts managed by this group.
  # @attr_reader name [String] The base name used for generating test script names within the group.
  #
  # @example Initializing a TestScriptGroup with a TSV file path, start character for naming, limit on test cases, and a make argument basename
  #   test_script_group = Mkspec::TestScriptGroup.new("/path/to/tsv_file.tsv", "A", 50, "make_arg_basename")
  class TestScriptGroup
    attr_reader :testscripts, :name

    # Default values used for test case configuration. These values are used as fallbacks when specific
    # configurations are not provided in the TSV input file. The structure includes test conditions,
    # expected values, messages, and tags for both positive and negative test scenarios.
    DEFAULT_VALUES = ['to',  'be_successfully_executed', 'execute successfully', 'test_normal_sh:true', 'not_to',
                      'have_output(/error:/)', "don't have error in output", 'test_normal_sh_out:true'].freeze

    # Initializes a new instance of the TestScriptGroup class.
    # It sets up the group with a path to a TSV file containing test case definitions, a starting character
    # for script naming, a limit on the number of test cases per script, and a base name for make arguments.
    #
    # @param tsv_path [String] The file path to the TSV file containing test case definitions.
    # @param start_char [String] The starting character used for naming the test scripts within the group.
    # @param limit [Integer] The maximum number of test cases allowed per test script.
    # @param make_arg_basename [String] The base name used for generating make arguments for the test cases.
    def initialize(tsv_path, start_char, limit, make_arg_basename)
      @tsv_path = tsv_path
      raise MkspecAppError, "testscriptgroup.rb 1 start_char.class=#{start_char.class}" unless Util.not_empty_string?(start_char).first

      @name = start_char
      @limit = limit
      @make_arg_basename = make_arg_basename
      @testscripts = []
      @current_testscript = make_testscript(@name)
    end

    def setup_test_group(line, state)
      # tgroup, tcase, tmp = l.chomp.split(/\s+|\t+/)
      tgroup, tcase, *tmp = line.chomp.split("\t")
      if tgroup.nil?
        Loggerxcm.debug("tgroup=#{tgroup}|")
        retirm self
      end
      if tgroup =~ /^\s*#/
        Loggerxcm.debug("testscriptgroup.rb 3")
        return self
      end
      if tcase.nil?
        Loggerxcm.debug("testscriptgroup.rb 4")
        return self
      end
      if tcase =~ /^\s*#/
        Loggerxcm.debug("testscriptgroup.rb 5")
        return self
      end
      if tmp.size > 4
        Loggerxcm.debug("testscriptgroup.rb 6")
        return self
      end

      (1..7).each do |num|
        if Util.check_numeric(tmp, num)
          Loggerxcm.debug("testscriptgroup.rb #{num}")
          return self
        end
      end

      # Loggerxcm.debug("tmp=#{tmp}")
      tgroup = tgroup.tr('-', '_').tr('.', '_')
      testgroup = (state[tgroup] ||= TestGroup.new(tgroup, @make_arg_basename))
      tcase = tcase.tr('-', '_').tr('.', '_')
      array = DEFAULT_VALUES.zip(tmp[0, 8]).map { |lh, rh| rh.nil? ? lh : rh }
      extra = tmp[4, tmp.size]
      # Loggerxcm.debug("array=#{array}")
      test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag = array
      testgroup.add_test_case("#{testgroup}_#{tcase}", tcase, test_1, test_1_value, test_1_message, test_1_tag, test_2,
                              test_2_value, test_2_message, test_2_tag, extra)
      self
    end

    # Reads the TSV file and sets up test groups and test cases based on its content.
    # This method iterates over each line in the TSV file, skipping comments and empty lines,
    # and processes the test definitions to organize them into test scripts and groups.
    def setup_from_tsv
      File.readlines(@tsv_path).each_with_object({}) do |l, state|
        next if l =~ /^\s*#/
        next if l =~ /^\s*$/

        setup_test_group(l, state)
      end
    end

    # Sets up the test script group by processing the TSV file and organizing the test cases
    # into test scripts based on the defined criteria, such as the limit on the number of test cases.
    # It ensures that test cases are distributed across test scripts in a way that adheres to the limit,
    # creating new test scripts as necessary.
    #
    # @return [TestScriptGroup] The instance of TestScriptGroup, allowing for method chaining.
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

    # Creates a new test script instance with a given name and adds it to the collection of test scripts.
    #
    # @param name [String] The name for the new test script.
    # @return [TestScript] The newly created TestScript instance.
    def make_testscript(name)
      ts = TestScript.new(name, @limit)
      @testscripts << ts
      ts
    end

    # Generates the next name for a test script based on the current name, incrementing it to create a sequence.
    #
    # @return [String] The next name in the sequence.
    def next_name
      @name = @name.succ
    end

    # Returns the collection of test scripts that have been set up and organized within the group.
    #
    # @return [Array<TestScript>] The collection of test scripts.
    def result
      @testscripts
    end
  end
end
