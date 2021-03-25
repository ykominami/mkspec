# frozen_string_literal: true

module Mkspec

  class State
    attr_accessor :opt, :message, :exit_code


    def initialize
      @exit_code = SUCCESS
    end

    def success?
      @exit_code == SUCCESS
    end

    def change(exit_code, message = nil)
      @exit_code = exit_code
      @message = message
      self
    end

    def show_message
      Loggerxcm.error(@message)
      @exit_code
    end

    def show_usage_and_exit(opt, message)
      Loggerxcm.error_b do
        %w[
          #{message}
          #{opt.banner}
          #{@message}
        ]
      end
    end
  end

  STATE = State.new
end