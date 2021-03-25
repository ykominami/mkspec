# frozen_string_literal: true

require 'erubis'
require 'yaml'
require 'pathname'
require 'pp'
require 'pry'
require 'rufo'
require 'clitest'

module Mkspec
  SUCCESS = 0
  CMDLINE_OPTION_ERROR = 9
  CMDLINE_OPTION_ERROR_O = 10
  CMDLINE_OPTION_ERROR_T = 11
  CMDLINE_OPTION_ERROR_C = 12
  CMDLINE_OPTION_ERROR_S = 13
  CMDLINE_OPTION_ERROR_L = 14
  CMDLINE_OPTION_ERROR_G = 15
  CMDLINE_OPTION_ERROR_X = 16
  CMDLINE_OPTION_ERROR_Y = 17
  CMDLINE_OPTION_ERROR_Z = 18

  CANNOT_WRITE_SPEC_FILE = 20
  CANNOT_FIND_DATA_YAML_FILE = 30
  CANNOT_CONVERT_WITH_RUBO = 40
  CANNOT_WRITE_YAML_FILE = 50

  GLOBAL_YAML_FNAME = 'global_yaml_fname'
  ORIGINAL_OUTPUT_DIR = 'original_output_dir'
  TARGET_CMD_1_PN = 'target_cmd_1_pn'
  TARGET_CMD_2_PN = 'target_cmd_2_pn'
  MAKE_ARG = 'make_cmdline_1'
  MAKE_ARG_X = 'make_arg'
  TEST_CASE_DIR = 'test_case_dir'

  SPEC_DIR = "spec"
  SPEC_PN = Pathname.new(__FILE__).parent.parent + SPEC_DIR

  class Error < StandardError
    include Erubis::PrefixedLineEnhancer
  end
  # Your code goes here...

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
