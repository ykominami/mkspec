# frozen_string_literal: true

require 'erubis'
require 'yaml'
require 'pathname'
require 'pry'
require 'rufo'
require 'clitest'

require_relative 'mkspec/loggerxcm'

# Mkspecモジュール
module Mkspec
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
  # エラーコード：コマンドラインGGオプションエラー
  CMDLINE_OPTION_ERROR_GG = 19
  # エラーコード：コマンドラインTTオプションエラー
  Mkspec::CMDLINE_OPTION_ERROR_TT = 20
  # エラーコード：コマンドラインLLオプションエラー
  CMDLINE_OPTION_ERROR_LL = 21
  # エラーコード：コマンドラインDDオプションエラー
  CMDLINE_OPTION_ERROR_DD = 22

  # エラーコード：SPECファイル作成失敗
  CANNOT_MAKE_SPEC_FILE = 24
  # エラーコード：SPECファイル出力失敗
  CANNOT_WRITE_SPEC_FILE = 25
  # エラーコード：Invalid YAMLファイル
  INVALID_YAML_FILE = 26
  # エラーコード：データYAMLファイル未発見
  CANNOT_FIND_DATA_YAML_FILE = 30
  # エラーコード：RUBOライブラリでの変換失敗
  CANNOT_CONVERT_WITH_RUBO = 41
  # エラーコード：YAMLファイル出力失敗
  CANNOT_WRITE_YAML_FILE = 50
  # エラーコード：ERUBYテンプレート展開失敗
  CANNOT_FORMAT_WITH_ERUBY = 60
  # MkspecDebugError発生
  MKSPEC_DEBUG_ERROR = 100
  # MkspecAppError発生
  MKSPEC_APP_ERROR = 101
  # 

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
require_relative 'mkspec/globalconfig'
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
