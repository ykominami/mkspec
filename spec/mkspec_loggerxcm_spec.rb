# frozen_string_literal: true

require 'spec_helper_1'

begin
  require 'debug'
rescue StandardError => exc
  puts exc.message
end

logger_init_x

RSpec.describe 'Loggerxcm', type: :aruba do
  context 'with STATE is SUCCESS' do
    before(:all) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
    end

    let(:message_array) do
      [
        "string 1",
        "string 2"
      ]
    end
    let(:str) { "Fatal" }

    context 'when fatal' do
      let(:ret_string) { Mkspec::Loggerxcm.fatal(str) }
      let(:ret) { Mkspec::Loggerxcm.fatal(message_array) }

      it 'fatal for string', cmd: 11, kind: :fatal do
        expect(ret_string).to be(true)
      end

      it 'fatal for array of string', cmd: 12, kind: :fatal do
        expect(ret).to be(true)
      end
    end

    context 'when error' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.error(@message_array)
      end

      it 'error for array of string', cmd: 121, kind: :error do
        expect(@ret).to be(true)
      end
    end

    context 'when warn' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.warn(@message_array)
      end

      it 'warn for array of string', cmd: 122, kind: :warn do
        expect(@ret).to be(true)
      end
    end

    context 'when debug' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.debug(@message_array)
      end

      it 'debug for array of string', cmd: 123, kind: :debug do
        expect(@ret).to be(true)
      end
    end

    context 'when info' do
      before(:each) do
        @ret = Mkspec::Loggerxcm.info(@message_array)
      end

      it 'info for array of string', cmd: 124, kind: :info do
        expect(@ret).to be(true)
      end
    end
  end
end
