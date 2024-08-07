# frozen_string_literal: true

require "fileutils"
require "pathname"
require 'ostruct'

module Mkspec
  # The `Mkspec::GlobalConfig` class is designed to manage global configuration settings for the Mkspec framework.
  # It provides a centralized point of access for configuration parameters that affect the framework as a whole,
  # facilitating the management of settings such as environment variables, default paths, and other global preferences.
  # This class ensures that global settings are consistently applied across different components of the Mkspec framework,
  # making it easier to maintain and update configuration as needed.
  #
  # @example Accessing a global configuration value
  #   global_config = Mkspec::GlobalConfig.instance
  #   default_output_dir = global_config.default_output_dir
  #
  # This class utilizes the Singleton design pattern to ensure that only one instance of the configuration is created
  # and accessible throughout the application, providing a unified point of reference for global settings.
  class GlobalConfig
    attr_accessor :ost, :specific_hash

    #
    #     _TEST_TEMPLATE_AND_DATA = "_test_template_and_data"
    #
    #     INCLUDE_DIR = "_test_include"
    #     #
    #     # SPEC_DIRを表すキー
    #     SPEC_DIR_KEY = "SPEC_DIR"
    #     # ターゲットコマンド1のPathnameを表すキー
    #     TARGET_CMD_1_PN_KEY = "target_cmd_1_pn"
    #     # ターゲットコマンド2のPathnameを表すキー
    #     TARGET_CMD_2_PN_KEY = "target_cmd_2_pn"
    #     # tsv_fname_indexを表すキー
    #     TSV_FNAME_INDEX_KEY = "tsv_fname_index"
    #     # tsv_fname_arrayを表すキー
    #     TSV_FNAME_ARRAY_KEY = "tsv_fname_array"
    #     # tsv_fnameを表すキー
    #     TSV_FNAME_KEY = "tsv_fname"
    #
    # original_output_root_dir
    ORIGINAL_OUTPUT_ROOT_DIR_KEY = "original_output_root_dir"
    # スペシフィックYAMLファイルを表すキー
    SPECIFIC_YAML_FNAME_KEY = "specific_yaml_fname"
    # グローバルYAMLファイルを表すキー
    GLOBAL_YAML_FNAME_KEY = "global_yaml_fname"
    # オリジナル出力ディレクトリを表すキー
    ORIGINAL_OUTPUT_DIR_KEY = "original_output_dir"

    TEST_DIR = "test"
    # TEST_DIR = "test2"
    RESULT_FNAME = "result.txt"
    TEST_DATA_DIR = "_test_data"
    MISC_DIR = "misc"
    TSV_FNAME = "testlist-x.txt"
    TSV_FNAME_2 = "t.txt"
    CONTENT_FNAME = "content.txt"
    TESTDATA_FNAME = "testdata.txt"
    YAML_FNAME = "a.yml"
    OUTPUT_SCRIPT_DIR = "script"
    OUTPUT_TEMPLATE_AND_DATA_DIR = "template_and_data"
    OUTPUT_TEST_CASE_DIR = "test_case"
    TEST_CASE_ARCHIVE_DIR = "_test_case_archive"
    TEST_ARCHIVE_DIR = "_test_archive"
    # tsv_path_indexを表すキー
    TSV_PATH_INDEX_KEY = "tsv_path_index"
    # tsv_pathを表すキー
    TSV_PATH_ARRAY_KEY = "tsv_path_array"
    # 拡張コマンドライン作成を表すキー
    MAKE_ARG_KEY = "make_arg"
    # top_dirを表すキー
    TOP_DIR_KEY = "top_dir"
    # log_dirを表すキー
    LOG_DIR_KEY = "log_dir"
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
    TECSGEN_CMD_PATH_KEY = "tecsgen_cmd_path"
    # テストケースディレクトリを表すキー
    TEST_CASE_DIR_KEY = "test_case_dir"
    # tecsgenコマンドを表すキー
    TECSGEN_CMD_KEY = "tecsgen_cmd"
    # cmdを示すキー
    CMD_KEY = "cmd"
    # START_CHARを示すキー
    START_CHAR_KEY = "start_char"
    # LIMITを示すキー
    LIMIT_KEY = "limit"
    ###############
    TEST_MISC_DIR = "_test_misc"
    TEST_INCLUDE_DIR = "_test_include"
    TEST_CYGWIN_DIR = "_test_cygwin"
    TEST_CYGWIN3_DIR = "_test_cygwin3"

    DEFAULT_TOP_DIR = "."

    def initialize(new_count, init_hash, dirs_and_files, target_cmd_1 = nil, target_cmd_2 = nil)
      @new_count = new_count
      # global_yaml_pna = global_yaml.pathname
      global_yaml_pna = dirs_and_files.global_yaml.pathname
      unless global_yaml_pna.exist?
        Loggerxcm.debug("globalconfig.rb 2 #{global_yaml_pna}")
        return
      end
      specific_yaml_pna = dirs_and_files.specific_yaml.pathname
      Loggerxcm.debug "###########################################  specific_yaml_pna=#{specific_yaml_pna}"
      Loggerxcm.debug "specific_yaml_pna=#{specific_yaml_pna}"
      ret = Util.load_info(specific_yaml_pna)
      @specific_hash = ret.first
      Loggerxcm.debug "###########################################  Before merge @global_hash=#{@global_hash}"
      @specific_hash = @specific_hash.first if @specific_hash.instance_of?(Array)
      Loggerxcm.debug "###########################################  @specific_hash=#{@specific_hash}"
      @global_hash = Util.extract_in_yaml_file(global_yaml_pna, @specific_hash)
      Loggerxcm.debug "###########################################  After merge @global_hash=#{@global_hash}"
      result = Util.not_empty_hash?(@global_hash)
      unless result.first
        Loggerxcm.debug "globalconfig.rb 3"
        return
      end
      Loggerxcm.debug("GlobalConfig.initialize @global_hash=#{@global_hash}")
      Loggerxcm.debug("GlobalConfig.initialize @specific_hash=#{@specific_hash}")
      # return unless
      init_for_common(@specific_hash)
      # return unless
      init_for_ost(target_cmd_1, target_cmd_2, init_hash, global_yaml_pna)
      # return unless
      init_for_output(dirs_and_files)
      setup(@ost)
    end

    def init_for_output(dirs_and_files)
      pn = dirs_and_files.log_dir.pathname
      @ost.log_dir_pn = pn
      @ost.data_top_dir_pn = dirs_and_files.data_dir.pathname
      @ost.data_top_dir = @ost.data_top_dir_pn.to_s
      @ost.output_data_top_dir_pn = dirs_and_files.output_dir.pathname
      @ost.output_data_top_dir = @ost.output_data_top_dir_pn.to_s
      # raise
      @ost.spec_test_dir_pn = @ost.data_top_dir_pn.join(TEST_DIR)
      @ost.spec_test_test_misc_dir_pn = @ost.spec_test_dir_pn.join(TEST_MISC_DIR)
      @ost.spec_test_test_include_dir_pn = @ost.spec_test_dir_pn.join(TEST_INCLUDE_DIR)
      @ost.spec_test_test_cygwn_dir_pn = @ost.spec_test_dir_pn.join(TEST_CYGWIN_DIR)
      @ost.spec_test_test_cygwn3_dir_pn = @ost.spec_test_dir_pn.join(TEST_CYGWIN3_DIR)

      unless @ost.log_dir_pn.exist?
        Loggerxcm.debug "globalconfig.rb X4 | Can't find #{@ost.log_dir_pn}"
        return false
      end
      Loggerxcm.debug "@ost.log_dir_pn.expand_path=#{@ost.log_dir_pn.expand_path}"
      @ost.log_dir_pn.mkpath

      true
    end

    def setup(ost)
      # ost.test_root_dir_pn = ost.output_data_top_dir_pn.join(TEST_DIR)
      ost.test_root_dir_pn = ost.data_top_dir_pn.join(TEST_DIR)
      ost.test_root_dir = ost.test_root_dir_pn.to_s

      if ost.original_output_root_dir.nil?
        ost.target_parent_dir_pn = ost.test_root_dir_pn.join(ost.original_output_dir)
      else
        original_output_root_dir_pn = Pathname.new(ost.original_output_root_dir)
        ost.target_parent_dir_pn = original_output_root_dir_pn.join(ost.original_output_dir)
      end
      ost.target_parent_dir = ost.target_parent_dir_pn
      ost.result = RESULT_FNAME
      ost._test_data_dir_pn = ost.test_root_dir_pn.join(TEST_DATA_DIR)
      ost.misc_dir_pn = ost.test_root_dir_pn.join(MISC_DIR)
      ost.tsv_fname = TSV_FNAME
      ost.tsv_fname_2 = TSV_FNAME_2

      ost.misc_tsv_fname = ost.misc_dir_pn.join(ost.tsv_fname)
      ost.misc_tsv_fname_2 = ost.misc_dir_pn.join(ost.tsv_fname_2)

      # ost.output_dir_pn = ost.target_parent_dir_pn
      ost.output_dir = ENV.fetch("MKSPEC_OUTPUT_DIR", ost.target_parent_dir_pn)
      ost.output_dir_pn = Pathname.new(ost.output_dir)
      ost.output_template_and_data_dir_pn = ost.output_dir_pn.join(ost.tad_dir)
      ost.output_template_and_data_dir = ost.output_template_and_data_dir_pn.to_s
      ost.output_script_dir_pn = ost.output_dir_pn.join(ost.script_dir)
      ost.output_script_dir = ost.output_script_dir_pn.to_s
      ost.output_test_case_root_dir_pn = ost.output_dir_pn.join(OUTPUT_TEST_CASE_DIR)
      ost.output_test_case_root_dir = ost.output_test_case_root_dir_pn.to_s

      ost.content_fname = CONTENT_FNAME
      ost.testdata_fname = TESTDATA_FNAME
      ost.yaml_fname = YAML_FNAME
    end

    def init_for_common(specific_hash)
      ret, kind = Util.not_empty_hash?(specific_hash)
      unless ret
        Loggerxcm.debug("GlobalConfig.initialize @specific_hash.class=#{specific_hash.class}")
        Loggerxcm.debug("GlobalConfig.initialize kind=#{kind}")
        Loggerxcm.debug("globalconfig.rb 1")
        return false
      end

      @global_hash.merge!(specific_hash)
      true
    end

    def init_for_ost(target_cmd_1, target_cmd_2, init_hash, global_yaml_pna)
      @ost = OpenStruct.new
      @ost.cmd = @global_hash[CMD_KEY]
      @ost.start_char = @global_hash[START_CHAR_KEY]
      @ost.limit = @global_hash[LIMIT_KEY]
      @ost.target_cmd_1 = @global_hash[TARGET_CMD_1_KEY]
      @ost.target_cmd_2 = @global_hash[TARGET_CMD_2_KEY]
      @ost.target_cmd_1 = target_cmd_1 if target_cmd_1
      @ost.target_cmd_2 = target_cmd_2 if target_cmd_2
      @ost.make_arg = @global_hash[MAKE_ARG_KEY]
      @ost.tecsgen_base = @global_hash["tecsgen_base"]
      @ost.tecsgen_cmd = @global_hash[TECSGEN_CMD_KEY]
      @ost.tecsmerge_cmd = @global_hash["tecsmerge_cmd"]
      @ost.tecsgen_cmd_path = @global_hash[TECSGEN_CMD_PATH_KEY]
      @ost.tecsmerge_cmd_path = @global_hash["tecsmerge_cmd_path"]
      @ost.tecsgen_path = @global_hash["tecsgen_path"]
      @ost.tecspath = @global_hash[TECSPATH_KEY]
      @ost.data_dir_0 = @global_hash["data_dir_0"]
      @ost.sub_data_dir_1 = @global_hash["sub_data_dir_1"]
      @ost.sub_data_dir_2 = @global_hash["sub_data_dir_2"]
      @ost.test_case_dir = @global_hash[TEST_CASE_DIR_KEY]
      @ost.tad_dir_index = @global_hash["tad_dir_index"].to_i
      @ost.tad_dir_array = @global_hash["tad_dir_array"]
      @ost.tad_dir = @ost.tad_dir_array[@ost.tad_dir_index]

      @ost.script_dir_index = @global_hash["script_dir_index"]
      @ost.script_dir_array = @global_hash["script_dir_array"]
      @ost.script_dir = @ost.script_dir_array[@ost.script_dir_index]
      # "spec"
      @ost.tecsgen_top_dir = @global_hash["tecsgen_top_dir"]
      @ost.asp_dir = @global_hash["asp_dir"]
      @ost.asp3_dir = @global_hash["asp3_dir"]

      if init_hash["top_dir"]
        top_dir_original = init_hash["top_dir"]
        Loggerxcm.debug("1 GlobalConfig.new  top_dir_original=#{top_dir_original}")
      else
        top_dir_original = @global_hash["top_dir"]
        Loggerxcm.debug("2 GlobalConfig.new  top_dir_original=#{top_dir_original}")
      end
      top_dir_original_pn = Pathname.new(top_dir_original)
      top_dir_real_pn = top_dir_original_pn.expand_path
      @ost.top_dir_original_pn = top_dir_original_pn
      @ost.top_dir_original = top_dir_original
      @ost.top_dir_pn = top_dir_real_pn
      @ost.top_dir = top_dir_real_pn.to_s
      Loggerxcm.debug("GlobalConfig.new @ost.top_dir=#{@ost.top_dir}")
      # raise

      @ost.tsv_path_index = @global_hash["tsv_path_index"]
      @ost.tsv_path_array = @global_hash["tsv_path_array"]
      @ost.original_output_dir = @global_hash[get_key_of_original_output_dir].to_s
      if @new_count
        pn = Pathname.new(@ost.original_output_dir)
        Loggerxcm.debug("@ost.original_output_dir=#{@ost.original_output_dir}")
        basename = pn.basename
        if basename.to_s =~ /^([^\d]*)(\d+)$/
          str = ::Regexp.last_match(1)
          n = ::Regexp.last_match(2).to_i
          n += 1
          parent_pn = pn.parent
          loop do
            name = "#{str}#{n}"
            Loggerxcm.debug("name=#{name}")
            new_pn = parent_pn.join(name)
            if new_pn.exist?
              n += 1
            else
              @ost.original_output_dir = new_pn.to_s
              Loggerxcm.debug("@ost.original_output_dir=#{@ost.original_output_dir}")
              break
            end
          end
        end
      end

      @ost.global_yaml_pna = global_yaml_pna
      @ost.global_yaml_fname = global_yaml_pna.to_s

      if target_cmd_1
        unless target_cmd_2
          Logger.debug("globalconfig.rb 6")
          return false
        end
      elsif target_cmd_2
        Logger.debug("globalconfig.rb 7")
        return false
      end
      return false unless target_cmd_1 && target_cmd_2

      _tmp, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, ".", target_cmd_1, target_cmd_2)
      unless @ost.target_cmd_1_pn
        @ost.bin_dir_pn, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, "bin", target_cmd_1,
                                                                                    target_cmd_2)
      end
      return false if @ost.target_cmd_1_pn.nil?

      @ost.exe_dir_pn, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, "exe", target_cmd_1, target_cmd_2)

      # @ost
      true
    end

    def arrange(ost)
      # @global_hash.map { |x| ost[x[0]] = x[1] if ost[x[0]].nil? || ost[x[0]] =~ /^\s*$/ }
      @global_hash.map { |key, value| ost[key] = value if ost[key].nil? || ost[key].to_s =~ /^\s*$/ }
    end

    def tsv_path
      index = @ost.tsv_path_index
      tsv_path_array = @ost.tsv_path_array
      tsv_path = tsv_path_array[index]
      Pathname.new(tsv_path)
    end

    def make_arg
      @ost.make_arg
    end

    def tecspath
      @ost.tecspath
    end

    def tecsgen_cmd_path
      @ost.tecsgen_cmd_path
    end

    def global_yaml_fname
      @ost.global_yaml_fname
    end

    def test_case_dir
      @ost.test_case_dir
    end

    def tecsgen_cmd
      @ost.tecsgen_cmd
    end

    def target_cmd_1
      @ost.target_cmd_1
    end

    def target_cmd_2
      @ost.target_cmd_2
    end

    def top_dir
      # raise MkspecAppError.new("globalconfig.rb X-2") unless Util.not_empty_string?(@ost.top_dir).first
      raise MkspecAppError, "globalconfig.rb X-2" unless Util.not_empty_string?(@ost.top_dir)

      @ost.top_dir.to_s
    end

    def output_dir
      @ost.original_output_dir
    end

    def get_key_of_global_yaml_fname
      GLOBAL_YAML_FNAME_KEY
    end

    def get_key_of_tecsgen_cmd
      TECSGEN_CMD_KEY
    end

    def get_key_of_tecsgen_cmd_path
      TECSGEN_CMD_PATH_KEY
    end

    def get_key_of_tecspath
      TECSPATH_KEY
    end

    def get_key_of_tecspath_cmd_path
      TECSPATH_CMD_PATH_KEY
    end

    def get_key_of_original_output_dir
      ORIGINAL_OUTPUT_DIR_KEY
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

    def get_key_of_top_dir
      TOP_DIR_KEY
    end
  end
end
