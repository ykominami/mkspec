# frozen_string_literal: true

require "fileutils"
require "pathname"
require 'ostruct'

module Mkspec
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
    # original_spec_file_pathを表すキー
    ORIGINAL_SPEC_FILE_PATH_KEY = "original_spec_file_path"
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
    ROOT_OUTPUT_DIR = "test_auto"
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

    def initialize(new_count, init_hash, specific_yaml_pn, global_yaml_pna, target_cmd_1 = nil, target_cmd_2 = nil, original_spec_file_path = nil)
      @new_count = new_count
      # specific_yaml_pn = specific_yaml.pathname
      Loggerxcm.debug("specific_yaml_pn=#{specific_yaml_pn}")
      @specific_hash = Util.extract_in_yaml_file(specific_yaml_pn, init_hash)

      # global_yaml_pna = global_yaml.pathname
      raise Mkspec::MkspecAppError, "globalconfig.rb 2 #{global_yaml_pna}" unless global_yaml_pna.exist?

      @global_hash = Util.extract_in_yaml_file(global_yaml_pna, @specific_hash)
      raise MkspecAppError, "globalconfig.rb 3" unless Util.not_empty_hash?(@global_hash).first

      Loggerxcm.debug("GlobalConfig.initialize @global_hash=#{@global_hash}")

      init_for_common
      init_for_ost(target_cmd_1, target_cmd_2, original_spec_file_path, init_hash, global_yaml_pna, specific_yaml_pn)
      init_for_source(original_spec_file_path, global_yaml_pna)
      init_for_output
      setup(@ost)
    end

    def init_for_source(original_spec_file_path, global_yaml_pna)
      @ost.original_output_root_dir = @global_hash["original_output_root_dir"]
      @ost.log_dir = @global_hash[LOG_DIR_KEY]
      log_dir = ENV.fetch("MKSPEC_LOG_DIR", @ost.log_dir)
      @ost.log_dir_pn = Pathname.new(log_dir)
      parent_dir = @ost.log_dir_pn.parent.to_s
      FileUtils.mkdir_p(parent_dir)
      global_yaml_original_pn = global_yaml_pna
      global_yaml_real_pn = global_yaml_original_pn.expand_path

      @ost.data_top_dir_original_pn = global_yaml_original_pn.parent
      @ost.data_top_dir_original = @ost.data_top_dir_original_pn.to_s

      @ost.data_top_dir_pn = global_yaml_real_pn.parent
      @ost.data_top_dir = @ost.data_top_dir_pn.to_s

      spec_file_setup(@ost, original_spec_file_path) if original_spec_file_path

      raise Mkspec::MkspecDebugError, "globalconfig.rb X1" unless global_yaml_pna.parent
      raise Mkspec::MkspecDebugError, "globalconfig.rb X2" unless @ost.data_top_dir_pn
      raise Mkspec::MkspecDebugError, "globalconfig.rb X3" unless @ost.top_dir_pn
      raise Mkspec::MkspecDebugError, "globalconfig.rb X31" unless @ost.top_dir_pn.exist?
    end

    def init_for_output
      valid_original_root_output_dir = false
      if @ost.original_root_output_dir.nil? == false
        @ost.original_root_output_dir_pn = Pathname.new(@ost.original_root_output_dir)
        valid_original_root_output_dir = true if @ost.original_root_output_dir_pn.exist?
      end
      @ost.output_data_top_dir_pn = if valid_original_root_output_dir
                                      @ost.original_root_output_dir_pn
                                    else
                                      @ost.data_top_dir_pn
                                    end
      @ost.output_data_top_dir = @ost.output_data_top_dir_pn.to_s

      raise Mkspec::MkspecDebugError, "globalconfig.rb X4 | Can't find #{@ost.log_dir_pn}" unless @ost.log_dir_pn.exist?
      raise Mkspec::MkspecDebugError, "globalconfig.rb X41" unless @ost.log_dir_pn.exist?

      Loggerxcm.debug "@ost.log_dir_pn=#{@ost.log_dir_pn}"
      Loggerxcm.debug "@ost.log_dir_pn.expand_path=#{@ost.log_dir_pn.expand_path}"
      @ost.log_dir_pn.mkpath
    end

    def setup(ost)
      ost.test_root_dir_pn = ost.output_data_top_dir_pn.join(TEST_DIR)
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

    def init_for_common
      ret, kind = Util.not_empty_hash?(@specific_hash)
      unless ret
        Loggerxcm.debug("GlobalConfig.initialize @specific_hash.class=#{@specific_hash.class}")
        Loggerxcm.debug("GlobalConfig.initialize kind=#{kind}")
        raise Mkspec::MkspecDebugError, "globalconfig.rb 1"
      end

      @global_hash.merge!(@specific_hash)
    end

    def init_for_ost(target_cmd_1, target_cmd_2, original_spec_file_path, init_hash, global_yaml_pna, specific_yaml_pn)
      ost = OpenStruct.new
      @ost = ost
      @ost.cmd = @global_hash[CMD_KEY]
      @ost.start_char = @global_hash[START_CHAR_KEY]
      @ost.limit = @global_hash[LIMIT_KEY]
      @ost.target_cmd_1 = @global_hash[TARGET_CMD_1_KEY]
      @ost.target_cmd_2 = @global_hash[TARGET_CMD_2_KEY]
      @ost.target_cmd_1 = target_cmd_1 if target_cmd_1
      @ost.target_cmd_2 = target_cmd_2 if target_cmd_2
      #@ost.target_cmd_2.x
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

      @ost.specific_yaml_fname = specific_yaml_pn.to_s

      @ost.global_yaml_pna = global_yaml_pna
      @ost.global_yaml_fname = global_yaml_pna.to_s
      @ost.original_spec_file = original_spec_file_path

      if target_cmd_1
        raise MkspecAppError, "globalconfig.rb 6" unless target_cmd_2
      elsif target_cmd_2
        raise MkspecAppError, "globalconfig.rb 7"
      end
      return unless target_cmd_1 && target_cmd_2

      _tmp, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, ".", target_cmd_1, target_cmd_2)
      unless @ost.target_cmd_1_pn
        @ost.bin_dir_pn, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, "bin", target_cmd_1,
                                                                                    target_cmd_2)
      end
      return if @ost.target_cmd_1_pn.nil?

      @ost.exe_dir_pn, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, "exe", target_cmd_1, target_cmd_2)
    end

    def load_info(path)
      pna = Pathname.new(path)
      hash = if pna.exist?
               Util.extract_in_yaml_file(pna)
             else
               {}
             end
      [hash, pna]
    end

    def spec_file_setup(ost, original_spec_file_path)
      pn = Pathname.new(original_spec_file_path)
      if pn.dirname == "spec"
        spec_pn = pn.parent
      else
        pn = Pathname.new(ENV.fetch("PWD", nil))
        spec_pn = pn.join("spec")
        spec_pn = nil unless spec_pn.exist?
      end
      if spec_pn.nil? && ENV.fetch(SPEC_DIR_KEY, nil)
        spec_pn = Pathname.new(ENV.fetch(SPEC_DIR_KEY, nil))
        spec_pn = nil unless spec_pn.exist?
      end
      ost.original_output_dir_pn = pn

      ost.spec_pn = spec_pn
      ost.spec_dir = ost.spec_pn.to_s
      return unless Util.not_empty_string?(ost.top_dir)

      ost.spec_test_dir_pn = ost.data_top_dir_pn.join(TEST_DIR)
      ost.spec_test_test_misc_dir_pn = ost.spec_test_dir_pn.join(TEST_MISC_DIR)
      ost.spec_test_test_include_dir_pn = ost.spec_test_dir_pn.join(TEST_INCLUDE_DIR)
      ost.spec_test_test_cygwn_dir_pn = ost.spec_test_dir_pn.join(TEST_CYGWIN_DIR)
      ost.spec_test_test_cygwn3_dir_pn = ost.spec_test_dir_pn.join(TEST_CYGWIN3_DIR)
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
