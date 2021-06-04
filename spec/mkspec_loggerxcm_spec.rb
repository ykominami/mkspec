# frozen_string_literal: true

require 'spec_helper'
require 'pry'
require 'pp'

RSpec.describe 'Loggerxcm', type: :aruba do
  include TestConf

  context 'fatal' do
    before(:all) do
      Mkspec::Loggerxcm.init(:default, true, :fatal)
      @str="Fatal"
      @message_array = [
        "fatal 1",
        "fatal 2"
      ]
    end

    context 'fatal error' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.fatal(@str)
      end
      it 'error for string' , kind:"fatal", cmd:11 do expect(@ret).to eq(true) end
    end

    context 'fatal error' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.fatal(@message_array)
      end

      it 'error for array' , kind:"fatal", cmd:12 do expect(@ret).to eq(true) end
    end

    context 'fatal error' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@message_array)
      end

      it 'error for array' , kind:"fatal", cmd:121 do expect(@ret).to eq(true) end
    end

    context 'fatal warn' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@message_array)
      end

      it 'error for array' , kind:"fatal", cmd:122 do expect(@ret).to eq(true) end
    end

    context 'fatal debug' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@message_array)
      end

      it 'error for array' , kind:"fatal", cmd:123 do expect(@ret).to eq(true) end
    end

    context 'fatal info' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@message_array)
      end

      it 'error for array' , kind:"fatal", cmd:124 do expect(@ret).to eq(true) end
    end
  end

  context 'error' do
    before(:all) do
      Mkspec::Loggerxcm.init(:default, true, :error)
      @str="error 1"
      @message_array = [
        "error 1",
        "error 2"
      ]
    end

    context 'error 1' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@str)
      end
      it 'error for string' , kind:"error", cmd:21 do expect(@ret).to eq(true) end
    end

    context 'error 2' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@message_array)
      end

      it 'error for array' , kind:"error", cmd:22 do expect(@ret).to eq(true) end
    end

    context 'error fatal' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.fatal(@message_array)
      end

      it 'error for array fatal' , kind:"error", cmd:221 do expect(@ret).to eq(true) end
    end

    context 'error warn' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@message_array)
      end

      it 'error for array warn' , kind:"error", cmd:222 do expect(@ret).to eq(true) end
    end

    context 'error debug' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@message_array)
      end

      it 'error for array debug' , kind:"error", cmd:223 do expect(@ret).to eq(true) end
    end

    context 'error info' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@message_array)
      end

      it 'error for array info' , kind:"error", cmd:224 do expect(@ret).to eq(true) end
    end
  end

  context 'warn' do
    before(:all) do
      Mkspec::Loggerxcm.init(:default, true, :warn)
      @str="warn 1"
      @message_array = [
        "warn 1",
        "warn 2"
      ]
    end

    context 'warn 1' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@str)
      end
      it 'warn for string' , kind:"warn", cmd:31 do expect(@ret).to eq(true) end
    end

    context 'warn warn message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@message_array)
      end

      it 'warn for array warn warn' , kind:"warn", cmd:32 do expect(@ret).to eq(true) end
    end

    context 'warn fatal message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.fatal(@message_array)
      end

      it 'warn for array fatal' , kind:"warn", cmd:321 do expect(@ret).to eq(true) end
    end

    context 'warn error message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@message_array)
      end

      it 'warn for array error' , kind:"warn", cmd:322 do expect(@ret).to eq(true) end
    end

    context 'warn debug message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@message_array)
      end

      it 'warn for array debug' , kind:"warn", cmd:323 do expect(@ret).to eq(true) end
    end

    context 'warn debug message_array info' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@message_array)
      end

      it 'warn for array info' , kind:"warn", cmd:324 do expect(@ret).to eq(true) end
    end
  end

  context 'info' do
    before(:all) do
      Mkspec::Loggerxcm.init(:default, true, :info)
      @str="info 1"
      @message_array = [
          "info 1",
          "info 2"
        ]
    end

    context 'info 1' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@str)
      end
      it 'info for string' , kind:"info", cmd:41 do expect(@ret).to eq(true) end
    end

    context 'info 2' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@message_array)
      end

      it 'info for array' , kind:"info", cmd:42 do expect(@ret).to eq(true) end
    end

    context 'info fatal message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.fatal(@message_array)
      end

      it 'info for array fatal' , kind:"info", cmd:421 do expect(@ret).to eq(true) end
    end

    context 'info error message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@message_array)
      end

      it 'info for array error' , kind:"info", cmd:422 do expect(@ret).to eq(true) end
    end

    context 'info warn message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@message_array)
      end

      it 'info for array warn' , kind:"info", cmd:423 do expect(@ret).to eq(true) end
    end

    context 'info debug message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@message_array)
      end

      it 'info for array debug' , kind:"info", cmd:424 do expect(@ret).to eq(true) end
    end
  end

  context 'debug' do
    before(:all) do
      Mkspec::Loggerxcm.init(:default, true, :debug)
      @str="debug 1"
      @message_array = [
        "debug 1",
        "debug 2"
      ]
    end

    context 'debug 1' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@str)
      end
      it 'debug for string' , kind:"debug", cmd:51 do expect(@ret).to eq(true) end
    end

    context 'debug 2' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@message_array)
      end

      it 'debug fatal for array' , kind:"debug", cmd:52 do expect(@ret).to eq(true) end
    end

    context 'debug fatal message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.fatal(@message_array)
      end

      it 'debug for array fatal' , kind:"debug", cmd:521 do expect(@ret).to eq(true) end
    end

    context 'debug error message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@message_array)
      end

      it 'debug for array error' , kind:"debug", cmd:522 do expect(@ret).to eq(true) end
    end

    context 'debug warn message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@message_array)
      end

      it 'debug for array warn' , kind:"debug", cmd:523 do expect(@ret).to eq(true) end
    end

    context 'debug info message_array' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@message_array)
      end

      it 'debug for array info' , kind:"debug", cmd:524 do expect(@ret).to eq(true) end
    end
  end
end
