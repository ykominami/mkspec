module Mkspec
  class GlobalConfig
    attr_accessor :o, :specific_hash
=begin

    _TEST_TEMPLATE_AND_DATA = "_test_template_and_data"


    INCLUDE_DIR = "_test_include"
    #
    # SPEC_DIRを表すキー
    SPEC_DIR_KEY = "SPEC_DIR"
    # ターゲットコマンド1のPathnameを表すキー
    TARGET_CMD_1_PN_KEY = "target_cmd_1_pn"
    # ターゲットコマンド2のPathnameを表すキー
    TARGET_CMD_2_PN_KEY = "target_cmd_2_pn"
    # tsv_fname_indexを表すキー
    TSV_FNAME_INDEX_KEY = "tsv_fname_index"
    # tsv_fname_arrayを表すキー
    TSV_FNAME_ARRAY_KEY = "tsv_fname_array"
    # tsv_fnameを表すキー
    TSV_FNAME_KEY = "tsv_fname"

=end
    # original_output_root_dir
    ORIGINAL_OUTPUT_ROOT_DIR_KEY = "original_output_root_dir"
    # スペシフィックYAMLファイルを表すキー
    SPECIFIC_YAML_FNAME_KEY = "specific_yaml_fname"
    # グローバルYAMLファイルを表すキー
    GLOBAL_YAML_FNAME_KEY = "global_yaml_fname"
    # original_spec_file_pathを表すキー
    ORIGINAL_SPEC_FILE_PATH_KEY = "original_spec_file_path"
    # コマンドライン作成を表すキー
    MAKE_ARG_KEY = "make_arg"
    # オリジナル出力ディレクトリを表すキー
    ORIGINAL_OUTPUT_DIR_KEY = "original_output_dir"

    TEST_DIR = "test"
    #TEST_DIR = "test2"
    RESULT_FNAME = "result.txt"
    TEST_DATA_DIR = "_test_data"
    MISC_DIR = "misc"
    TSV_FNAME = "testlist-x.txt"
    TSV_FNAME_2 = "t.txt"
    CONTENT_FNAME = "content.txt"
    TESTDATA_FNAME = "testdata.txt"
    YAML_FNAME = "a.yml"
    ROOT_OUTPUT_DIR = "test_auto"
    OUTPUT_SCRIPT_DIR = "script"
    OUTPUT_TEMPLATE_AND_DATA_DIR = "template_and_data"
    OUTPUT_TEST_CASE_DIR = "test_case"
    TEST_CASE_ARCHIVE_DIR = "_test_case_archive"
    TEST_ARCHIVE_DIR = '_test_archive'
    # tsv_path_indexを表すキー
    TSV_PATH_INDEX_KEY = "tsv_path_index"
    # tsv_pathを表すキー
    TSV_PATH_KEY = "tsv_path"
    # 拡張コマンドライン作成を表すキー
    MAKE_ARG_X_KEY = "make_arg_x"
    # top_dirを表すキー
    TOP_DIR_KEY = "top_dir"
    # コマンドライン作成を表すキー
    MAKE_CMDLINE_1_KEY = "make_cmdline_1"
    # ターゲットコマンド1のパスを表すキー
    TARGET_CMD_1_KEY = "target_cmd_1"
    # ターゲットコマンド2のパスを表すキー
    TARGET_CMD_2_KEY = "target_cmd_2"
    # tecspathを表すキー
    TECSPATH_KEY = "tecspath"
    # tecspath_cmd_pathを表すキー
    TECSPATH_CMD_PATH_KEY = "tecspath_cmd_path"
    # tecsgen_cmdのパスを表すキー
    TECSGEN_CMD_PATH_KEY = "tecsgen_cmd"
    # テストケースディレクトリを表すキー
    TEST_CASE_DIR_KEY = "test_case_dir"
    # tecsgenコマンドを表すキー
    TECSGEN_CMD_KEY = "tecsgen_cmd"

    ###############
    TEST_MISC_DIR = "_test_misc"
    TEST_INCLUDE_DIR = "_test_include"
    TEST_CYGWIN_DIR = "_test_cygwin"
    TEST_CYGWIN3_DIR = "_test_cygwin3"


    def initialize(top_dir_yaml, specific_yaml, global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path = nil, top_dir)
      #unless Util.nil_or_not_empty_string?(top_dir)
      #  raise(Mkspec::MkspecAppError, "globalconfig.rb initialize 1")
      #end
      top_dir_yaml_pn = Pathname.new(top_dir_yaml)
      @top_dir_hash = Util.extract_in_yaml_file(top_dir_yaml_pn)

      specific_yaml_pn = Pathname.new(specific_yaml)
      @specific_hash = Util.extract_in_yaml_file(specific_yaml_pn, @top_dir_hash)
      ret, kind = Util.not_empty_hash?(@specific_hash)
      unless ret
        Loggerxcm.debug("GlobalConfig.initialize @specific_hash.class=#{@specific_hash.class}")
        Loggerxcm.debug("GlobalConfig.initialize kind=#{kind}")
        raise(Mkspec::MkspecDebugError, "globalconfig.rb 1")
      end
      global_yaml_pn = Pathname.new(global_yaml)
      raise(Mkspce::MkspecAppError, "globalconfig.rb 2") unless global_yaml_pn.exist?
      @global_hash = Util.extract_in_yaml_file(global_yaml_pn, @specific_hash)
      raise(MkspecAppError, "globalconfig.rb 3") unless Util.not_empty_hash?(@global_hash).first
      Loggerxcm.debug("GlobalConfig.initialize @global_hash=#{@global_hash}")

      o = OpenStruct.new
      @o = o
      @o.data_top_dir_pn = global_yaml_pn.parent

      valid_original_output_root_dir = false
      @o.original_root_output_dir = @specific_hash[ get_key_of_original_root_output_dir ]
      if @o.original_root_output_dir != nil
        @o.original_root_output_dir_pn = Pathname.new(@o.original_root_output_dir)
        if @o.original_root_output_dir_pn.exist?
          valid_original_root_output_dir = true
        end
      end
      if valid_original_root_output_dir
        @o.output_data_top_dir_pn = @o.original_root_output_dir_pn
      else
        @o.output_data_top_dir_pn = @o.data_top_dir_pn
      end
      @o.output_data_top_dir = @o.output_data_top_dir_pn.to_s

      # raise(Mkspec::MkspecDebugError, "globalconfig.rb X1") unless @o.original_root_output_dir_pn
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X2") unless global_yaml_pn.parent
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X") unless @o.data_top_dir_pn


      @global_hash[SPECIFIC_YAML_FNAME_KEY] = specific_yaml_pn.to_s

      @global_hash[GLOBAL_YAML_FNAME_KEY] = global_yaml_pn.to_s
      #
      @global_hash[ORIGINAL_SPEC_FILE_PATH_KEY] = original_spec_file_path

      @o.target_cmd_1 = target_cmd_1
      @o.target_cmd_2 = target_cmd_2
      basic_setup(@o)
      if original_spec_file_path
        spec_file_setup(@o, original_spec_file_path)
      else
        unless Util.not_empty_string?(top_dir).first
          raise(MkspecAppError, "globalconfig.rb 4")
        end
        @o.top_dir = top_dir.to_s
        @o.top_dir_pn = Pathname.new(top_dir)
        raise(MkspecAppError, "globalconfig.rb 5") unless @o.top_dir_pn.exist?
      end

      if target_cmd_1
        raise(MkspecAppError, "globalconfig.rb 6") unless target_cmd_2
      else
        raise(MkspecAppError, "globalconfig.rb 7") if target_cmd_2
      end
      if target_cmd_1 && target_cmd_2
        _tmp, @o.target_cmd_1_pn, @o.target_cmd_2_pn = Util.get_path(@o.top_dir_pn, ".", target_cmd_1, target_cmd_2)
        @o.bin_dir_pn, @o.target_cmd_1_pn, @o.target_cmd_2_pn = Util.get_path(o.top_dir_pn, "bin", target_cmd_1, target_cmd_2) unless @o.target_cmd_1_pn
        @o.exe_dir_pn, @o.target_cmd_1_pn, @o.target_cmd_2_pn = Util.get_path(o.top_dir_pn, "exe", target_cmd_1, target_cmd_2) unless @o.target_cmd_1_pn
        #o.make_arg_basename = 'make_cmdline_1'
      end
      setup(@o)
    end

    def basic_setup(o)
      o.global_yaml_fname = @global_hash[GLOBAL_YAML_FNAME_KEY]
      o.specific_yaml_fname = @global_hash[SPECIFIC_YAML_FNAME_KEY]
      o.make_arg = MAKE_ARG_KEY
      o.original_output_dir = @global_hash[ get_key_of_original_output_dir ]
      Loggerxcm.debug("GlobalConfig.initialize @global_hash=#{@global_hash}")
    end

    def spec_file_setup(o, original_spec_file_path)
      pn = Pathname.new(original_spec_file_path)
      if pn.dirname == "spec"
        spec_pn = pn.parent
      else
        pn = Pathname.new(ENV["PWD"])
        spec_pn = pn.join("spec")
        spec_pn = nil unless spec_pn.exist?
      end
      if spec_pn == nil
        if ENV[SPEC_DIR_KEY]
          spec_pn = Pathname.new(ENV[SPEC_DIR_KEY])
          spec_pn = nil unless spec_pn.exist?
        end
      end
      o.original_output_dir_pn = pn

      #
      o.spec_pn = spec_pn
      #
      o.spec_dir = o.spec_pn.to_s
      o.top_dir_pn = o.spec_pn.parent
      o.top_dir = o.top_dir_pn.to_s
      raise(MkspecAppError, "globalconfig.rb X") unless Util.not_empty_string?(top_dir).first
      o.spec_test_dir_pn = o.data_top_dir_pn.join(TEST_DIR)
      o.spec_test_test_misc_dir_pn = o.spec_test_dir_pn.join(TEST_MISC_DIR)
      o.spec_test_test_include_dir_pn = o.spec_test_dir_pn.join(TEST_INCLUDE_DIR)
      o.spec_test_test_cygwn_dir_pn = o.spec_test_dir_pn.join(TEST_CYGWIN_DIR)
      o.spec_test_test_cygwn3_dir_pn = o.spec_test_dir_pn.join(TEST_CYGWIN3_DIR)
    end

    def setup(o)
      o.test_root_dir_pn = o.output_data_top_dir_pn.join(TEST_DIR)
      o.test_root_dir = o.test_root_dir_pn.to_s

      if o.original_output_root_dir != nil
        original_output_root_dir_pn = Pathname.new(o.original_output_root_dir)
        o.target_parent_dir_pn = original_output_root_dir_pn.join(o.original_output_dir)
      else
        o.target_parent_dir_pn = o.test_root_dir_pn.join(o.original_output_dir)
      end
      o.target_parent_dir = o.target_parent_dir_pn
      o.result = RESULT_FNAME
      o._test_data_dir_pn = o.test_root_dir_pn.join(TEST_DATA_DIR)
      o.misc_dir_pn = o.test_root_dir_pn.join(MISC_DIR)
      o.tsv_fname = TSV_FNAME
      o.tsv_fname_2 = TSV_FNAME_2

      o.misc_tsv_fname = o.misc_dir_pn.join(o.tsv_fname)
      o.misc_tsv_fname_2 = o.misc_dir_pn.join(o.tsv_fname_2)

      #
      o.output_dir_pn = o.target_parent_dir_pn
      o.output_dir = o.output_dir_pn.to_s
      #
      o.output_template_and_data_dir_pn = o.output_dir_pn.join("template_and_data")
      o.output_template_and_data_dir = o.output_template_and_data_dir_pn.to_s
      o.output_script_dir_pn = o.output_dir_pn.join("script")
      o.output_script_dir = o.output_script_dir_pn.to_s
      o.output_test_case_root_dir_pn = o.output_dir_pn.join("test_case")
      o.output_test_case_root_dir = o.output_test_case_root_dir_pn.to_s

      o.template_and_data_dir_pn = o.output_dir_pn.join("template_and_data")
      o.content_fname = CONTENT_FNAME
      o.testdata_fname = TESTDATA_FNAME
      o.yaml_fname = YAML_FNAME
    end

    def arrange(o)
      @global_hash.map { |x| o[x[0]] = x[1] if o[x[0]] == nil || o[x[0]] =~ /^\s*$/ }
    end

    def tsv_path
      index = @specific_hash[TSV_PATH_INDEX_KEY]
      tsv_path_array = @specific_hash[TSV_PATH_KEY]
      tsv_path = tsv_path_array[index]
      Pathname.new(tsv_path)
    end

    def make_arg_x
      @global_hash[MAKE_ARG_X_KEY]
    end

    def make_arg
      @global_hash[MAKE_ARG_KEY]
    end

    def target_cmd_1_pn
      @o.target_cmd_1_pn
    end

    def target_cmd_2_pn
      @o.target_cmd_2_pn
    end

    def tecspath
      @global_hash[TECSPATH_KEY]
    end

    def tecsgen_cmd_path
      @global_hash[TECSGEN_CMD_PATH_KEY]
    end

    def global_yaml_fname
      @global_hash[GLOBAL_YAML_FNAME_KEY]
    end

    def test_case_dir
      @global_hash[TEST_CASE_DIR_KEY]
    end

    def tecsgen_cmd
      @global_hash[TECSGEN_CMD_KEY]
    end

    def target_cmd_1
      @o.target_cmd_1
    end

    def target_cmd_2
      @o.target_cmd_2
    end

    def top_dir
      raise(MkspecAppError, "globalconfig.rb X-2") unless Util.not_empty_string?(o.top_dir).first
      @o.top_dir.to_s
    end

    def get_key_of_global_yaml_fname
      GLOBAL_YAML_FNAME_KEY
    end

    def get_key_of_tecspath
      TECSPATH_KEY
    end

    def get_key_of_tecspath_cmd_path
      TECSPATH_CMD_PATH_KEY
    end

    def get_key_of_original_root_output_dir
      ORIGINAL_OUTPUT_ROOT_DIR_KEY
    end

    def get_key_of_original_output_dir
      ORIGINAL_OUTPUT_DIR_KEY
    end

    def get_key_of_target_cmd_1_pn
      TARGET_CMD_1_PN_KEY
    end

    def get_key_of_target_cmd_2_pn
      TARGET_CMD_2_PN_KEY
    end

    def get_key_of_target_cmd_1
      TARGET_CMD_1_KEY
    end

    def get_key_of_target_cmd_2
      TARGET_CMD_2_KEY
    end

    def get_key_of_test_case_dir
      TEST_CASE_DIR_KEY
    end

    def get_key_of_tecsgen_cmd
      TECSGEN_CMD_KEY
    end

    def get_key_of_top_dir
      TOP_DIR_KEY
    end

    def output_dir
      @global_hash[ get_key_of_original_output_dir ]
    end
  end
end
