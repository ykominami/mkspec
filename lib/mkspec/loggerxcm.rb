# frozen_string_literal: true

module Mkspec
  class Loggerxcm0
    require 'logger'
    require 'fileutils'
    require 'stringio'

    LOG_FILENAME_BASE ||= "#{Time.now.strftime("%Y%m%d-%H%M%S")}.log"
    @log_file ||= nil
    @log_stdout ||= nil
    @stdout_backup = $stdout
    @stringio = StringIO.new( +"", 'w+')

    class << self
      def init(prefix, fname, log_dir, stdout_flag, level = :info)
        unless @log_file
          level_hs = {
            debug: Logger::DEBUG,
            info: Logger::INFO,
            warn: Logger::WARN,
            error: Logger::ERROR,
            fatal: Logger::FATAL,
            unknown: Logger::UNKNOWN
          }

          fname = nil if fname == false
          fname = prefix + LOG_FILENAME_BASE if fname == :default
          filepath = Pathname.new(log_dir).join(fname)
          @log_file ||= Logger.new(filepath) unless fname.nil?
          @log_stdout ||= Logger.new(STDOUT) if stdout_flag

          obj = proc do |_, _, _, msg| "#{msg}\n" end
          register_log_format(obj)
          register_log_level(level_hs[level])

          @stdout_backup ||= $stdout
          @stringio ||= StringIO.new( +"", 'w+')
        end
=begin
        @stderr_backup ||= $stderr
        @stringio ||= StringIO.new( +"", 'w+')
=end
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
          @stdout_backup = $stdout unless @stdout_backup
          @stringio = StringIO.new( +"", 'w+') unless @stringio
          $stdout = @stringio
          pp value
          $stdout = @stdout_backup
          str = @stringio.read
          @stringio.truncate(0)
          str
        else
          value
        end
      end

      def show(value)
        str = to_string(value)
        @log_file&.error(str)
        @log_stdout&.error(str)
        puts(str) unless @log_stdout
        true
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
  end

  class Loggerxcm < Loggerxcm0
  end

  class Loggerxcmcli < Loggerxcm0
  end

  class Loggerxcmspec < Loggerxcm0
  end
end
