# frozen_string_literal: true

module Mkspec
  require 'logger'
  require 'fileutils'

  class Loggerxcm
    LOG_FILE = "logtest-#{Time.now.strftime("%Y%m%d-%H%M%S")}.log"
    @log_file = nil
    @log_stdout = nil

    class << self
      def init(fname, stdout, level = :info)
        unless @log_file
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
          @log_stdout = Logger.new(STDOUT) if stdout

          obj = proc do |_, _, _, msg| "#{msg}\n" end
          register_log_format(obj)
          register_log_level(level_hs[level])
        end
      end

      def register_log_format(obj)
        @log_file&.formatter = obj
        @log_stdout&.formatter = obj
      end

      def register_log_level(level)
        @log_file&.level = level
        @log_stdout&.level = level
        #
        # Log4r互換インターフェイス
        # DEBUG < INFO < WARN < ERROR < FATAL < UNKNOWN
      end

      def to_string(value)
        if value.instance_of?(Array)
          value.join("\n")
        else
          value
        end
      end

      def error(value)
        str = to_string(value)
        @log_file&.error(str)
        @log_stdout&.error(str)
        true
      end

      def debug(value)
        str = to_string(value)
        @log_file&.debug(str)
        @log_stdout&.debug(str)
        true
      end

      def info(value)
        str = to_string(value)
        @log_file&.info(str)
        @log_stdout&.info(str)
        true
      end

      def warn(value)
        str = to_string(value)
        @log_file&.warn(str)
        @log_stdout&.warn(str)
        true
      end

      def fatal(value)
        str = to_string(value)
        @log_file&.fatal(str)
        @log_stdout&.fatal(str)
        true
      end

      def close
        @log_file&.close
        # @log_stdout&.close
      end
    end
    #  Loggerxcm.init(:default, true, :unknown)
    #  Loggerxcm.init(:default, true, :fatal)
    #  Loggerxcm.init(:default, true, :error)
    #  Loggerxcm.init(:default, true, :warn)
    #  Loggerxcm.init(:default, true, :info)
    #  Loggerxcm.init(:default, true, :debug)
    #  Loggerxcm.init(:default, false, :debug)
  end
end
