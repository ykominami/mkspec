# frozen_string_literal: true

module Mkspec

  class State
     attr_accessor :message, :exit_code
#    attr_accessor :message

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

    def show_message(message = nil)
      ary = []
      ary << @message if @message
      ary << message if message
      Loggerxcm.show(ary)
      @exit_code
    end
  end

  STATE = State.new
end