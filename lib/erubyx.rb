# frozen_string_literal: true

require 'erubis'
require 'yaml'
require 'pathname'
require 'pp'
require 'pry'
require 'rufo'
require 'clitest'

module Erubyx
  SUCCESS = 0
  CMDLINE_OPTION_ERROR = 10
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

require_relative 'erubyx/version'
require_relative 'erubyx/root'
require_relative 'erubyx/setting'
require_relative 'erubyx/templatex'
require_relative 'erubyx/testcase'
require_relative 'erubyx/testgroup'
require_relative 'erubyx/testscript'
require_relative 'erubyx/testscriptgroup'
require_relative 'erubyx/mkscript'
require_relative 'erubyx/config'
require_relative 'erubyx/loggerxcm'
require_relative 'erubyx/item'
require_relative 'erubyx/util'

require_relative 'erubyx/state'
