# frozen_string_literal: true

module Mkspec
  class State
    attr_accessor :message_array, :exit_code

    def initialize
      @exit_code = SUCCESS
      @message_array = []
    end

    def success?
      @exit_code == SUCCESS
    end

    def finish?
      @exit_code == FINISH
    end

    def change(exit_code, *message)
      @exit_code = exit_code
      @message_array = message
      self
    end

    def show_message(_message = nil)
      ary = []
      ary << @message_array if @message_array
      Loggerxcm.show(ary)
      @exit_code
    end
  end

  STATE = State.new
end
