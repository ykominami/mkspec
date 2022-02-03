# frozen_string_literal: true

module Mkspec
  class Loggerxcm0
    require 'logger'
    require 'fileutils'
    require 'stringio'

    LOG_FILENAME_BASE ||= "#{Time.now.strftime("%Y%m%d-%H%M%S")}.log"
    @log_file ||= nil
    @log_stdout ||= nil
    p "0 $stdout=#{$stdout}"
    @stdout_backup = $stdout
    @stringio = StringIO.new( +"", 'w+')
    p "0 @stdout_backup=#{@stdout_backup}"
    p "0 @stringio=#{@stringio}"
    
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
        end
        @stdout_backup ||= $stdout
        @stringio ||= StringIO.new( +"", 'w+')
        p "init self=#{self} self.class=#{self.class}"
        p "init $stdout=#{$stdout}"
        p "init @stdout_backup=#{@stdout_backup}"
        p "init @stringio=#{@stringio}"
        @stdout_backup ||= $stdout
        @stringio ||= StringIO.new( +"", 'w+')
        p "init 2 self=#{self} self.class=#{self.class}"
        p "init 2 $stdout=#{$stdout}"
        p "init 2 @stdout_backup=#{@stdout_backup}"
        p "init 2 @stringio=#{@stringio}"
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
          p "2 self=#{self} self.class=#{self.class}"
          p "2 $stdout=#{$stdout}"
          p "2 @stdout_backup=#{@stdout_backup}"
          p "2 @stringio=#{@stringio}"
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
        p "1 self=#{self} self.class=#{self.class}"
        p "1 $stdout=#{$stdout}"
        p "1 @stdout_backup=#{@stdout_backup}"
        p "1 @stringio=#{@stringio}"

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
