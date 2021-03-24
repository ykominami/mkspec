# frozen_string_literal: true

module Erubyx

  class State
    attr_accessor :opt, :message, :exit_code


    def initialize
      @exit_code = SUCCESS
    end

    def success?
      @exit_code == SUCCESS
    end

    def change(exit_code, message = nil)
      binding.pry
      @exit_code = exit_code
      @message = message
      self
    end

    def show_usage_and_exit(opt, message)
      Loggerxcm.error_b do
        %w[
          message
          opt.banner
          Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
        ]
      end
      Loggerxcm.error_b do
        [
          message,
          opt.banner,
          Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
        ]
      end
    end
  end

  STATE = State.new
end