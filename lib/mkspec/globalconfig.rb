require 'pp'
require 'fileutils'

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
    ORIGINAL_OUTPUT_ROOT_DIR_KEY = "original_output_root_dir".freeze
    # TOP DIR YAMLファイルを表すキー
    TOP_DIR_YAML_FNAME_KEY = "top_dir_yaml_fname".freeze
    # RESOLVED TOP DIR YAMLファイルを表すキー
    RESOLVED_TOP_DIR_YAML_FNAME_KEY = "resolved_top_dir_yaml_fname".freeze
    # スペシフィックYAMLファイルを表すキー
    SPECIFIC_YAML_FNAME_KEY = "specific_yaml_fname".freeze
    # グローバルYAMLファイルを表すキー
    GLOBAL_YAML_FNAME_KEY = "global_yaml_fname".freeze
    # original_spec_file_pathを表すキー
    ORIGINAL_SPEC_FILE_PATH_KEY = "original_spec_file_path".freeze
    # オリジナル出力ディレクトリを表すキー
    ORIGINAL_OUTPUT_DIR_KEY = "original_output_dir".freeze

    TEST_DIR = "test".freeze
    #TEST_DIR = "test2"
    RESULT_FNAME = "result.txt".freeze
    TEST_DATA_DIR = "_test_data".freeze
    MISC_DIR = "misc".freeze
    TSV_FNAME = "testlist-x.txt".freeze
    TSV_FNAME_2 = "t.txt".freeze
    CONTENT_FNAME = "content.txt".freeze
    TESTDATA_FNAME = "testdata.txt".freeze
    YAML_FNAME = "a.yml".freeze
    ROOT_OUTPUT_DIR = "test_auto".freeze
    OUTPUT_SCRIPT_DIR = "script".freeze
    OUTPUT_TEMPLATE_AND_DATA_DIR = "template_and_data".freeze
    OUTPUT_TEST_CASE_DIR = "test_case".freeze
    TEST_CASE_ARCHIVE_DIR = "_test_case_archive".freeze
    TEST_ARCHIVE_DIR = '_test_archive'.freeze
    # tsv_path_indexを表すキー
    TSV_PATH_INDEX_KEY = "tsv_path_index".freeze
    # tsv_pathを表すキー
    TSV_PATH_ARRAY_KEY = "tsv_path_array".freeze
    # 拡張コマンドライン作成を表すキー
    MAKE_ARG_KEY = "make_arg".freeze
    # top_dirを表すキー
    TOP_DIR_KEY = "top_dir".freeze
    # log_dirを表すキー
    LOG_DIR_KEY = "log_dir".freeze
    # コマンドライン作成を表すキー
    MAKE_CMDLINE_1_KEY = "make_cmdline_1".freeze
    # ターゲットコマンド1のパスを表すキー
    TARGET_CMD_1_KEY = "target_cmd_1".freeze
    # ターゲットコマンド2のパスを表すキー
    TARGET_CMD_2_KEY = "target_cmd_2".freeze
    # tecspathを表すキー
    TECSPATH_KEY = "tecspath".freeze
    # tecspath_cmd_pathを表すキー
    TECSPATH_CMD_PATH_KEY = "tecspath_cmd_path".freeze
    # tecsgen_cmdのパスを表すキー
    TECSGEN_CMD_PATH_KEY = "tecsgen_cmd".freeze
    # テストケースディレクトリを表すキー
    TEST_CASE_DIR_KEY = "test_case_dir".freeze
    # tecsgenコマンドを表すキー
    TECSGEN_CMD_KEY = "tecsgen_cmd".freeze

    ###############
    TEST_MISC_DIR = "_test_misc".freeze
    TEST_INCLUDE_DIR = "_test_include".freeze
    TEST_CYGWIN_DIR = "_test_cygwin".freeze
    TEST_CYGWIN3_DIR = "_test_cygwin3".freeze

    DEFAULT_TOP_DIR = ".".freeze

    def initialize(top_dir_yaml, resolved_top_dir_yaml, specific_yaml, global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path = nil)
      @top_dir_pna, top_dir_yaml_pna, resolved_top_dir_yaml_pna = setup_top_dir(top_dir_yaml, resolved_top_dir_yaml)
      @top_dir_hash = {}
      @top_dir_hash[TOP_DIR_KEY] = @top_dir_pna.to_s

      specific_yaml_pn = Pathname.new(specific_yaml)
      @specific_hash = Util.extract_in_yaml_file(specific_yaml_pn, @top_dir_hash)
      ret, kind = Util.not_empty_hash?(@specific_hash)
      unless ret
        Loggerxcm.debug("GlobalConfig.initialize @specific_hash.class=#{@specific_hash.class}")
        Loggerxcm.debug("GlobalConfig.initialize kind=#{kind}")
        raise(Mkspec::MkspecDebugError, "globalconfig.rb 1")
      end
      # @specific_hash.merge!(@top_dir_hash)

      global_yaml_pna = Pathname.new(global_yaml)
      raise(Mkspec::MkspecAppError, "globalconfig.rb 2 #{global_yaml}") unless global_yaml_pna.exist?

      @global_hash = Util.extract_in_yaml_file(global_yaml_pna, @specific_hash)
      raise(MkspecAppError, "globalconfig.rb 3") unless Util.not_empty_hash?(@global_hash).first

      Loggerxcm.debug("GlobalConfig.initialize @global_hash=#{@global_hash}")

      @global_hash.merge!(@specific_hash)

      ost = OpenStruct.new
      @ost = ost

      @ost.make_arg = @global_hash[MAKE_ARG_KEY]
      @ost.tecsgen_base = @global_hash['tecsgen_base']
      @ost.tecsgen_cmd = @global_hash[TECSGEN_CMD_KEY]
      @ost.tecsmerge_cmd = @global_hash['tecsmerge_cmd']
      @ost.tecsgen_cmd_path = @global_hash['tecsgen_cmd_path']
      @ost.tecsmerge_cmd_path = @global_hash['tecsmerge_cmd_path']
      @ost.tecsgen_path = @global_hash['tecsgen_path']
      @ost.tecspath = @global_hash[TECSPATH_KEY]
      @ost.data_dir_0 = @global_hash['data_dir_0']
      @ost.sub_data_dir_1 = @global_hash['sub_data_dir_1']
      @ost.sub_data_dir_2 = @global_hash['sub_data_dir_2']
      @ost.original_output_dir = @global_hash[ORIGINAL_OUTPUT_DIR_KEY]
      @ost.test_case_dir = @global_hash['test_case_dir']
      @ost.tad_dir_index = @global_hash['tad_dir_index']
      @ost.tad_dir_array = @global_hash['tad_dir_array']
      @ost.script_dir_index = @global_hash['script_dir_index']
      @ost.script_dir_array = @global_hash['script_dir_array']
      @ost.tecsgen_top_dir = @global_hash['tecsgen_top_dir']
      @ost.asp_dir = @global_hash['asp_dir']
      @ost.asp3_dir = @global_hash['asp3_dir']
      @ost.top_dir = @global_hash['top_dir']
      @ost.tsv_path_index = @global_hash['tsv_path_index']
      @ost.tsv_path_array = @global_hash['tsv_path_array']
      @ost.original_output_dir = @global_hash[get_key_of_original_output_dir]

      @ost.original_output_root_dir = @global_hash['original_output_root_dir']
      @ost.log_dir = @global_hash[LOG_DIR_KEY]
      @ost.log_dir_pn = Pathname.new(@ost.log_dir)

      @ost.top_dir = @top_dir_pna.to_s
      @ost.top_dir_pn = @top_dir_pna
      @ost.data_top_dir_pn = global_yaml_pna.parent
      @ost.data_top_dir = @ost.data_top_dir_pn.to_s
      @ost.resolved_top_dir_yaml_fname = resolved_top_dir_yaml_pna.to_s

      valid_original_output_root_dir = false
      unless @ost.original_root_output_dir.nil?
        @ost.original_root_output_dir_pn = Pathname.new(@ost.original_root_output_dir)
        valid_original_root_output_dir = true if @ost.original_root_output_dir_pn.exist?
      end
      @ost.output_data_top_dir_pn = if valid_original_root_output_dir
                                      @ost.original_root_output_dir_pn
                                    else
                                      @ost.data_top_dir_pn
                                    end
      @ost.output_data_top_dir = @ost.output_data_top_dir_pn.to_s

      # raise(Mkspec::MkspecDebugError, "globalconfig.rb X1") unless @ost.original_root_output_dir_pn
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X1") unless global_yaml_pna.parent
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X2") unless @ost.data_top_dir_pn
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X3") unless @ost.top_dir_pn
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X31") unless @ost.top_dir_pn.exist?

      # puts "@ost.log_dir_pn=#{@ost.log_dir_pn}"
      # raise(Mkspec::MkspecDebugError, "globalconfig.rb X31") unless @ost.top_dir_pn.exist?
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X4") unless @ost.log_dir_pn.exist?

      ret = @ost.log_dir_pn.exist?
      raise(Mkspec::MkspecDebugError, "globalconfig.rb X41") unless ret

      @ost.top_dir_yaml_pna = top_dir_yaml_pna
      @ost.top_dir_yaml_fname = top_dir_yaml_pna.to_s
      @ost.resolved_top_dir_yaml_pma = resolved_top_dir_yaml_pna
      @ost.resolved_top_dir_yaml = resolved_top_dir_yaml_pna.to_s
      @ost.specific_yaml_fname = specific_yaml_pn.to_s

      @ost.global_yaml_pna = global_yaml_pna
      @ost.global_yaml_fname = global_yaml_pna.to_s
      @ost.original_spec_file = original_spec_file_path

      @ost.target_cmd_1 = target_cmd_1
      @ost.target_cmd_2 = target_cmd_2
      # basic_setup(@ost)
      if original_spec_file_path
        spec_file_setup(@ost, original_spec_file_path)
      else
        raise(MkspecAppError, "globalconfig.rb 4") unless Util.not_empty_string?(top_dir).first
        raise(MkspecAppError, "globalconfig.rb 5") unless @ost.top_dir_pn.exist?
      end

      if target_cmd_1
        raise(MkspecAppError, "globalconfig.rb 6") unless target_cmd_2
      elsif target_cmd_2
        raise(MkspecAppError, "globalconfig.rb 7")
      end
      if target_cmd_1 && target_cmd_2
        _tmp, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, ".", target_cmd_1, target_cmd_2)
        unless @ost.target_cmd_1_pn
          @ost.bin_dir_pn, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, "bin", target_cmd_1,
                                                                                      target_cmd_2)
        end
        unless @ost.target_cmd_1_pn
          @ost.exe_dir_pn, @ost.target_cmd_1_pn, @ost.target_cmd_2_pn = Util.get_path(@ost.top_dir_pn, "exe", target_cmd_1,
                                                                                      target_cmd_2)
        end
      end
      setup(@ost)
    end

    def load_info(path)
      pna = Pathname.new(path)
      if pna.exist?
        hash = Util.extract_in_yaml_file(pna)
      else
        hash = {}
      end
      [hash, pna]
    end

    def save_info(path, hash)
      content = YAML.dump(hash)
      File.write(path, content)
    end

    def load_resolved_top_dir(resolved_top_dir_yaml)
      hash, pna = load_info(resolved_top_dir_yaml)
      [hash[TOP_DIR_KEY], pna]
    end

    def load_top_dir(top_dir_yaml)
      hash, pna = load_info(top_dir_yaml)
      [hash[TOP_DIR_KEY], pna]
    end

    def ensure_absolute_top_dir(pna)
      pna = pna.expand_path
      FileUtils.mkdir_p(pna.to_s)
      hash = {}
      hash[TOP_DIR_KEY] = pna.to_s
      hash
    end

    def setup_top_dir(top_dir_yaml, resolved_top_dir_yaml)
      top_dir_pna = nil
      top_dir_yaml_pna = Pathname.new(top_dir_yaml)
      resolved_top_dir_yaml_pna = Pathname.new(resolved_top_dir_yaml)
      top_dir, resolved_top_dir_yaml_pna = load_resolved_top_dir(resolved_top_dir_yaml)
      if top_dir.nil?
        top_dir, top_dir_yaml_pna = load_top_dir(top_dir_yaml)
        top_dir ||= DEFAULT_TOP_DIR
        top_dir_pna = Pathname.new(top_dir)
        if top_dir_pna.relative?
          hash = ensure_absolute_top_dir(top_dir_pna)
          save_info(resolved_top_dir_yaml_pna, hash)
        end
      end
      top_dir_pna ||= Pathname.new(top_dir)

      [top_dir_pna, top_dir_yaml_pna, resolved_top_dir_yaml_pna]
    end

    def spec_file_setup(ost, original_spec_file_path)
      pn = Pathname.new(original_spec_file_path)
      if pn.dirname == "spec"
        spec_pn = pn.parent
      else
        pn = Pathname.new(ENV["PWD"])
        spec_pn = pn.join("spec")
        spec_pn = nil unless spec_pn.exist?
      end
      if spec_pn.nil? && (ENV[SPEC_DIR_KEY])
        spec_pn = Pathname.new(ENV[SPEC_DIR_KEY])
        spec_pn = nil unless spec_pn.exist?
      end
      ost.original_output_dir_pn = pn

      ost.spec_pn = spec_pn
      ost.spec_dir = ost.spec_pn.to_s
      ost.top_dir_pn = ost.spec_pn.parent
      ost.top_dir = ost.top_dir_pn.to_s
      raise(MkspecAppError, "globalconfig.rb X") unless Util.not_empty_string?(top_dir).first

      ost.spec_test_dir_pn = ost.data_top_dir_pn.join(TEST_DIR)
      ost.spec_test_test_misc_dir_pn = ost.spec_test_dir_pn.join(TEST_MISC_DIR)
      ost.spec_test_test_include_dir_pn = ost.spec_test_dir_pn.join(TEST_INCLUDE_DIR)
      ost.spec_test_test_cygwn_dir_pn = ost.spec_test_dir_pn.join(TEST_CYGWIN_DIR)
      ost.spec_test_test_cygwn3_dir_pn = ost.spec_test_dir_pn.join(TEST_CYGWIN3_DIR)
    end

    def setup(ost)
      ost.test_root_dir_pn = ost.output_data_top_dir_pn.join(TEST_DIR)
      ost.test_root_dir = ost.test_root_dir_pn.to_s

      if !ost.original_output_root_dir.nil?
        original_output_root_dir_pn = Pathname.new(ost.original_output_root_dir)
        ost.target_parent_dir_pn = original_output_root_dir_pn.join(ost.original_output_dir)
      else
        ost.target_parent_dir_pn = ost.test_root_dir_pn.join(ost.original_output_dir)
      end
      ost.target_parent_dir = ost.target_parent_dir_pn
      ost.result = RESULT_FNAME
      ost._test_data_dir_pn = ost.test_root_dir_pn.join(TEST_DATA_DIR)
      ost.misc_dir_pn = ost.test_root_dir_pn.join(MISC_DIR)
      ost.tsv_fname = TSV_FNAME
      ost.tsv_fname_2 = TSV_FNAME_2

      ost.misc_tsv_fname = ost.misc_dir_pn.join(ost.tsv_fname)
      ost.misc_tsv_fname_2 = ost.misc_dir_pn.join(ost.tsv_fname_2)

      ost.output_dir_pn = ost.target_parent_dir_pn
      ost.output_dir = ost.output_dir_pn.to_s
      ost.output_template_and_data_dir_pn = ost.output_dir_pn.join("template_and_data")
      ost.output_template_and_data_dir = ost.output_template_and_data_dir_pn.to_s
      ost.output_script_dir_pn = ost.output_dir_pn.join("script")
      ost.output_script_dir = ost.output_script_dir_pn.to_s
      ost.output_test_case_root_dir_pn = ost.output_dir_pn.join("test_case")
      ost.output_test_case_root_dir = ost.output_test_case_root_dir_pn.to_s

      ost.template_and_data_dir_pn = ost.output_dir_pn.join("template_and_data")
      ost.content_fname = CONTENT_FNAME
      ost.testdata_fname = TESTDATA_FNAME
      ost.yaml_fname = YAML_FNAME
    end

    def arrange(ost)
      # @global_hash.map { |x| ost[x[0]] = x[1] if ost[x[0]].nil? || ost[x[0]] =~ /^\s*$/ }
      @global_hash.map { |key, value| ost[key] = value if ost[key].nil? || ost[key] =~ /^\s*$/ }
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
      raise(MkspecAppError, "globalconfig.rb X-2") unless Util.not_empty_string?(@ost.top_dir).first

      @ost.top_dir.to_s
    end

    def output_dir
      @ost.original_output_dir
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
