# frozen_string_literal: true
require 'erubis'
require 'yaml'
require 'pathname'
require 'pp'
require 'pry'

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

module Erubyx
  MAKE_ARG = "make_arg"

  EXIT_CODE_OF_CMDLINE_OPTION_ERROR = 10

  class Error < StandardError; 
    include Erubis::PrefixedLineEnhancer
  end
  # Your code goes here...

  class PrefixedLineEruby < Erubis::Eruby
    include Erubis::PrefixedLineEnhancer
  end
end