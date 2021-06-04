# frozen_string_literal: true

require 'erubis'
require 'yaml'
require 'pathname'
require 'pp'
require 'pry'
require 'rufo'
require 'clitest'

require_relative 'mkspec/loggerxcm'

# Mkspecモジュール
module Mkspec
  Loggerxcm.init(:default, false, :error)
#  Loggerxcm.init(:default, true, :error)
#  Loggerxcm.init(:default, true, :info)
#  Loggerxcm.init(:default, true, :debug)
#  Loggerxcm.init(:default, false, :debug)

  # エラーコード：成功
  SUCCESS = 0
  # エラーコード：コマンドラインオプションエラー
  INVALID_CMDLINE_OPTION_ERROR = 9
  # エラーコード：コマンドラインOオプションエラー
  CMDLINE_OPTION_ERROR_O = 10
  # エラーコード：コマンドラインTオプションエラー
  CMDLINE_OPTION_ERROR_T = 11
  # エラーコード：コマンドラインCオプションエラー
  CMDLINE_OPTION_ERROR_C = 12
  # エラーコード：コマンドラインSオプションエラー
  CMDLINE_OPTION_ERROR_S = 13
  # エラーコード：コマンドラインLオプションエラー
  CMDLINE_OPTION_ERROR_L = 14
  # エラーコード：コマンドラインGオプションエラー
  CMDLINE_OPTION_ERROR_G = 15
  # エラーコード：コマンドラインXオプションエラー
  CMDLINE_OPTION_ERROR_X = 16
  # エラーコード：コマンドラインYオプションエラー
  CMDLINE_OPTION_ERROR_Y = 17
  # エラーコード：コマンドラインZオプションエラー
  CMDLINE_OPTION_ERROR_Z = 18

  # エラーコード：SPECファイル出力失敗
  CANNOT_WRITE_SPEC_FILE = 20
  # エラーコード：データYAMLファイル未発見
  CANNOT_FIND_DATA_YAML_FILE = 30
  # エラーコード：RUBOライブラリでの変換失敗
  CANNOT_CONVERT_WITH_RUBO = 41
  # エラーコード：YAMLファイル出力失敗
  CANNOT_WRITE_YAML_FILE = 50
  # エラーコード：ERUBYテンプレート展開失敗
  CANNOT_FORMAT_WITH_ERUBY = 60
  # 

  # グローバルYAMLファイルを表すキー
  GLOBAL_YAML_FNAME = 'global_yaml_fname'
  # オリジナル出力ディレクトリを表すキー
  ORIGINAL_OUTPUT_DIR = 'original_output_dir'
  # ターゲットコマンド1のPathnameを表すキー
  TARGET_CMD_1_PN = 'target_cmd_1_pn'
  # ターゲットコマンド2のPathnameを表すキー
  TARGET_CMD_2_PN = 'target_cmd_2_pn'
  # コマンドライン作成を表すキー
  MAKE_ARG = 'make_cmdline_1'
  # 拡張コマンドライン作成を表すキー
  MAKE_ARG_X = 'make_arg'
  # テストケースディレクトリを表すキー
  TEST_CASE_DIR = 'test_case_dir'
  # tsv_fname_indexを表すキー
  TSV_FNAME_INDEX = "tsv_fname_index"
  # tsv_fname_arrayを表すキー
  TSV_FNAME_ARRAY = "tsv_fname_array"
  # tsv_pathを表すキー
  TSV_PATH = "tsv_path"
  # tsv_path_indexを表すキー
  TSV_PATH_INDEX_KEY = "tsv_path_index"
  # tsv_fnameを表すキー
  TSV_FNAME_KEY = "tsv_fname"

  # SPECファイルディレクトリを表すキー
  SPEC_DIR = "spec"
  # SPECファイルディレクトリのPathnameを表すキー
  SPEC_PN = Pathname.new(__FILE__).parent.parent + SPEC_DIR

  # 非Stringインスタンスエラークラス
  class NotStringInstError < StandardError
  end

  # 空文字列インスタンスエラークラス
  class EmptyStringError < StandardError
  end
  # Your code goes here...

  # 固定長インデント付きErubyテンプレートクラス
  #class PrefixedLineEruby < Erubis::Eruby
  #  include Erubis::PrefixedLineEnhancer
  #end

  class MkspecError < StandardError
  end

  class MkspecDebugError < MkspecError
  end

  class MkspecAppError < MkspecError
  end
end

require_relative 'mkspec/version'
require_relative 'mkspec/root'
require_relative 'mkspec/setting'
require_relative 'mkspec/templatex'
require_relative 'mkspec/testcase'
require_relative 'mkspec/testgroup'
require_relative 'mkspec/testscript'
require_relative 'mkspec/testscriptgroup'
require_relative 'mkspec/mkscript'
require_relative 'mkspec/config'
require_relative 'mkspec/item'
require_relative 'mkspec/util'
require_relative 'mkspec/state'
