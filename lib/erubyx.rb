# frozen_string_literal: true

require 'erubis'
require 'yaml'
require 'pathname'
require 'pp'
require 'pry'

module Erubyx
  MAKE_ARG = 'make_arg'

  EXIT_CODE_OF_CMDLINE_OPTION_ERROR = 10

  SPEC_DIR = "spec"
  SPEC_PN = Pathname.new(__FILE__).parent.parent + SPEC_DIR

  class Error < StandardError
    include Erubis::PrefixedLineEnhancer
  end
  # Your code goes here...

  class PrefixedLineEruby < Erubis::Eruby
    include Erubis::PrefixedLineEnhancer
  end

  class Objectx
    def self.init_log()
      @@loggerx ||= Loggerx.new(@@loggerx_file, @@loggerx_stdout, @@loggerx_level)
    end

    def self.init_log_with_file(fname = :default)
      @@loggerx_file = fname
    end

    def self.init_log_with_level(level = :info)
      @@loggerx_level = level
    end

    def self.init_log_with_stdout(stdout = true)
      @@loggerx_stdout = stdout
    end

    def initialize()
      Objectx.init_log
      @_log = @@loggerx
    end

#    Objectx.init_log_with_level(:info)
    Objectx.init_log_with_level(:debug)
    Objectx.init_log_with_file(:default)
    Objectx.init_log_with_stdout(true)
  end
end

require_relative 'erubyx/version'
require_relative 'erubyx/item'
require_relative 'erubyx/root'
require_relative 'erubyx/setting'
require_relative 'erubyx/templatex'
require_relative 'erubyx/testcase'
require_relative 'erubyx/testgroup'
require_relative 'erubyx/testscript'
require_relative 'erubyx/testscriptgroup'
require_relative 'erubyx/mkscript'
require_relative 'erubyx/config'
require_relative 'erubyx/loggerx'
