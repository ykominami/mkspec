# frozen_string_literal: true

module Erubyx
  require 'logger'
  require 'fileutils'

  class Loggerx
    LOG_FILE = "logtest.log"

    def initialize(fname, stdout, level = :info)
      level_hs = {
                  :info => Logger::INFO,
                  :debug => Logger::DEBUG,
                  :warn => Logger::WARN,
                  :error => Logger::ERROR,
                  :fatal => Logger::FATAL,
                  :unknown => Logger::UNKNOWN,
      }
      if fname == false
        fname = nil
      end
      if fname == :default
        fname = LOG_FILE
      end

      if fname != nil
        @log_file = Logger.new(fname)
      end
      if stdout
        @log_stdout = Logger.new(STDOUT)
      end

      obj = proc do |severity, datetime, progname, msg| "#{msg}\n" end
      set_format(obj)
      set_level(level)
    end

    def set_format(obj)
      @log_file.formatter = obj if @log_file
      @log_stdout.formatter = obj if @log_stdout
    end

    def set_level(level)
      @log_file.level = level if @log_file
      @log_stdout.level = level if @log_stdout
      #
      # Log4r互換インターフェイス
      # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
    end

    def block_call(block)
      if block.nil?
        value = block.call
        if value.instance_of(Array)
          str = value.join("\n")
        else
          str = value
        end
      end
    end

    def error(str)
      @log_file.error(str) if @log_file
      @log_stdout.error(str) if @log_stdout
    end

    def error_b(&block)
      str = block_call(block)
      error(str) if str
    end

    def debug(str)
      @log_file.debug(str) if @log_file
      @log_stdout.debug(str) if @log_stdout
    end

    def debug_b(&block)
      str = block_call(block)
      debug(str) if str
    end

    def info(str)
      @log_file.info(str) if @log_file
      @log_stdout.info(str) if @log_stdout
    end

    def info_b(&block)
      str = block_call(block)
      debug(str) if str
    end

    def warn(str)
      @log_file.warn(str) if @log_file
      @log_stdout.warn(str) if @log_stdout
    end

    def warn_b(&block)
      str = block_call(block)
      warn(str) if str
    end

    def fatal(str)
      @log_file.fatal(str) if @log_file
      @log_stdout.fatal(str) if @log_stdout
    end

    def fatal_b(&block)
      str = block_call(block)
      fatal(str) if str
    end

    def close
      @log_file.close if @log_file
      @log_stdout.close if @log_stdout
    end
  end
end
