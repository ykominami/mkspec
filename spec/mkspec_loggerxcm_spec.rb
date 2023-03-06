# frozen_string_literal: true

require 'spec_helper_1'
require 'pry'
require 'pp'

RSpec.describe 'Loggerxcm', type: :aruba do
  context 'STATE is SUCCESS' do
    before(:all) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @str = "Fatal"
      @message_array = [
        "string 1",
        "string 2"
      ]
    end

    context 'fatal' do
      before(:each) do
        @ret_string = Mkspec::Loggerxcm.fatal(@str)
        @ret = Mkspec::Loggerxcm.fatal(@message_array)
      end
      it 'fatal for string' , kind: :fatal, cmd: 11 do expect(@ret_string).to be(true) end
      it 'fatal for array of string' , kind: :fatal, cmd: 12 do expect(@ret).to be(true) end
    end

    context 'error' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@message_array)
      end

      it 'error for array of string' , kind: :error, cmd: 121 do expect(@ret).to be(true) end
    end

    context 'warn' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@message_array)
      end

      it 'warn for array of string' , kind: :warn, cmd: 122 do expect(@ret).to be(true) end
    end

    context 'debug' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@message_array)
      end

      it 'debug for array of string' , kind: :debug, cmd: 123 do expect(@ret).to be(true) end
    end

    context 'info' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@message_array)
      end

      it 'info for array of string' , kind: :info, cmd: 124 do expect(@ret).to be(true) end
    end
  end
end
