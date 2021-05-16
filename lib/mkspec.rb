# frozen_string_literal: true

require 'erubis'
require 'yaml'
require 'pathname'
require 'pp'
require 'pry'
require 'rufo'
require 'clitest'

# Mkspecモジュール
module Mkspec
  # エラーコード：成功
  SUCCESS = 0
  # エラーコード：コマンドラインオプションエラー
  CMDLINE_OPTION_ERROR = 9
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
  CANNOT_GET_RESULT_WITH_ERUBY = 60

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
  class PrefixedLineEruby < Erubis::Eruby
    include Erubis::PrefixedLineEnhancer
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
require_relative 'mkspec/loggerxcm'
require_relative 'mkspec/item'
require_relative 'mkspec/util'

require_relative 'mkspec/state'
