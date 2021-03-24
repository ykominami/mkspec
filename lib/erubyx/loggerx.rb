# frozen_string_literal: true

module Erubyx
  require 'logger'
  require 'fileutils'

  class Loggerx
    LOG_FILE = 'logtest.log'

    def initialize(fname, stdout, level = :info)
      level_hs = {
        info: Logger::INFO,
        debug: Logger::DEBUG,
        warn: Logger::WARN,
        error: Logger::ERROR,
        fatal: Logger::FATAL,
        unknown: Logger::UNKNOWN
      }
      fname = nil if fname == false
      fname = LOG_FILE if fname == :default
      @log_file = Logger.new(fname) unless fname.nil?
      @log_stdout = Logger.new($stdout) if stdout
      obj = proc do |_, _, _, msg| "#{msg}\n" end
      @log_format = obj
      @log_level = level_hs[level]
    end

    def log_format=(obj)
      @log_file.formatter = obj if @log_file
      @log_stdout.formatter = obj if @log_stdout
    end

    def log_level=(level)
      @log_file.level = level if @log_file
      @log_stdout.level = level if @log_stdout
      #
      # Log4r互換インターフェイス
      # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
    end

    def block_call(block)
      return unless block.nil?

      value = block.call
      if value.instance_of(Array)
        value.join("\n")
      else
        value
      end
    end

    def error(str)
      @log_file&.error(str)
      @log_stdout&.error(str)
    end

    def error_b(&block)
      str = block_call(block)
      error(str) if str
    end

    def debug(str)
      @log_file&.debug(str)
      @log_stdout&.debug(str)
    end

    def debug_b(&block)
      str = block_call(block)
      debug(str) if str
    end

    def info(str)
      @log_file&.info(str)
      @log_stdout&.info(str)
    end

    def info_b(&block)
      str = block_call(block)
      debug(str) if str
    end

    def warn(str)
      @log_file&.warn(str)
      @log_stdout&.warn(str)
    end

    def warn_b(&block)
      str = block_call(block)
      warn(str) if str
    end

    def fatal(str)
      @log_file&.fatal(str)
      @log_stdout&.fatal(str)
    end

    def fatal_b(&block)
      str = block_call(block)
      fatal(str) if str
    end

    def close
      @log_file&.close
      @log_stdout&.close
    end
  end
end
