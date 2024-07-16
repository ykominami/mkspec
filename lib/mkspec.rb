# frozen_string_literal: true

require 'erubis'
require 'yaml'
require 'pathname'
# require 'debug'
require 'rufo'
require 'clitest'
require 'fileutils'

require_relative 'mkspec/loggerxcm'

# Mkspecモジュール
module Mkspec
  # エラーコード：成功
  SUCCESS = 0
  # エラーコード：修了
  FINISH = 1
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
  # エラーコード：コマンドラインDオプションエラー
  CMDLINE_OPTION_ERROR_D = 15
  # エラーコード：コマンドラインGオプションエラー
  CMDLINE_OPTION_ERROR_G = 16
  # エラーコード：コマンドラインXオプションエラー
  CMDLINE_OPTION_ERROR_X = 17
  # エラーコード：コマンドラインYオプションエラー
  CMDLINE_OPTION_ERROR_Y = 18
  # エラーコード：コマンドラインZオプションエラー
  CMDLINE_OPTION_ERROR_Z = 19
  # エラーコード：コマンドラインDDオプションエラー
  CMDLINE_OPTION_ERROR_DD = 20
  # エラーコード：コマンドラインGGオプションエラー
  CMDLINE_OPTION_ERROR_GG = 21
  # エラーコード：コマンドラインLLオプションエラー
  CMDLINE_OPTION_ERROR_LL = 22
  # エラーコード：コマンドラインTTオプションエラー
  CMDLINE_OPTION_ERROR_TT = 23

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

  MKSPEC_ENV_VARIABLE_ERROR_TOP_DIR_YAML_FNAME = 201
  MKSPEC_ENV_VARIABLE_ERROR_RESOLVED_TOP_DIR_YAML_FNAME = 202
  MKSPEC_ENV_VARIABLE_ERROR_SPECIFIC_YAML_FNAME = 203
  MKSPEC_ENV_VARIABLE_ERROR_GLOBAL_YAML_FNAME = 204

  # デフォルトのログディレクトリ
  DEFAULT_LOG_DIR = "./logs"

  # 非Stringインスタンスエラークラス
  class NotStringInstError < StandardError
    attr_reader :attr

    def initialize(msg = "My default message", _message_array = [])
      @attr = attr
      super(msg)
    end
  end

  # 空文字列インスタンスエラークラス
  class EmptyStringError < StandardError
    attr_reader :message_array

    def initialize(msg = "My default message", message_array = [])
      @message_array = message_array
      super(msg)
    end
  end
  # Your code goes here...

  # The `Mkspec::MkspecError` class serves as a custom exception for the Mkspec framework.
  # It is designed to handle errors specific to the Mkspec operations, providing a more
  # granular control over error management within the framework. This class can be extended
  # to define various types of errors that are unique to the Mkspec's domain, facilitating
  # better error diagnosis and handling.
  #
  # @example Raising a Mkspec-specific error
  #   raise Mkspec::MkspecError.new("Specific error message")
  #
  # @param message [String] The error message describing what went wrong.
  class MkspecError < StandardError
    attr_reader :message_array

    def initialize(msg = "My default message", message_array = [])
      @message_array = message_array
      super(msg)
    end
  end

  # The `Mkspec::MkspecDebugError` class is a specialized error class within the Mkspec framework
  # designed to handle debugging-related errors. It extends `Mkspec::MkspecError`, inheriting its
  # capabilities to manage errors specific to Mkspec operations, with a focus on issues encountered
  # during debugging processes. This class allows for more detailed error reporting and handling
  # in scenarios where debugging information is crucial for diagnosing problems.
  #
  # @example Raising a MkspecDebug-specific error
  #   raise Mkspec::MkspecDebugError.new("Debug-specific error message")
  #
  # @param message [String] The error message describing the debugging issue.
  # @param message_array [Array] Optional array of additional messages or details related to the error.
  class MkspecDebugError < MkspecError
    # Implementation omitted
    attr_reader :message_array

    def initialize(msg = "My default message", message_array = [])
      @message_array = message_array
      super(msg)
    end
  end

  # The `Mkspec::MkspecAppError` class is a custom exception class within the Mkspec framework
  # designed to handle application-level errors. It extends `Mkspec::MkspecError`, leveraging its
  # capabilities for managing errors specific to Mkspec operations, but with a focus on errors that
  # occur at the application level. This distinction allows for more precise error handling and
  # categorization, facilitating better error diagnosis and management for application-specific issues.
  #
  # @example Raising an application-specific error
  #   raise Mkspec::MkspecAppError.new("Application-specific error message")
  #
  # @param message [String] The error message describing the application issue.
  # @param message_array [Array] Optional array of additional messages or details related to the error.
  class MkspecAppError < MkspecError
    attr_reader :message_array

    def initialize(msg = "My default message", message_array = [])
      @message_array = message_array
      super(msg)
    end
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
