# frozen_string_literal: true

module Mkspec
  # The `State` class is responsible for managing the state of operations within the Mkspec framework.
  # It tracks the execution status and messages related to the process, providing a mechanism to
  # determine success or failure and to relay messages back to the user or system.
  class State
    attr_accessor :message_array, :exit_code

    # @!attribute [rw] message_array
    #   @return [Array<String>] Stores messages related to the state change.
    # @!attribute [rw] exit_code
    #   @return [Integer] Represents the exit code of the operation, indicating success or failure.

    # Initializes a new instance of the State class, setting the default exit code to `SUCCESS`
    # and preparing an empty array for messages.
    def initialize
      @exit_code = SUCCESS
      @message_array = []
    end

    # Checks if the operation was successful based on the exit code.
    # @return [Boolean] true if the operation was successful, false otherwise.
    def success?
      @exit_code == SUCCESS
    end

    # Checks if the operation has finished based on the exit code.
    # @return [Boolean] true if the operation has finished, false otherwise.
    def finish?
      @exit_code == FINISH
    end

    # Changes the state of the operation, updating the exit code and messages.
    # @param exit_code [Integer] The new exit code to set.
    # @param message [Array<String>] Variable number of message strings related to the state change.
    # @return [State] The current instance of State, allowing for method chaining.
    def change(exit_code, *message)
      @exit_code = exit_code
      @message_array = message
      self
    end

    # Displays the messages associated with the state, optionally adding a new message.
    # @param _message [String, nil] An optional message to add to the display.
    # @return [Integer] The current exit code.
    def show_message(_message = nil)
      ary = []
      ary << @message_array if @message_array
      Loggerxcm.show(ary)
      @exit_code
    end
  end

  # A constant instance of the State class, providing a global state management mechanism.
  STATE = State.new
end
