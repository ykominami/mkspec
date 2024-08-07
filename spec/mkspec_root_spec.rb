# frozen_string_literal: true

require 'spec_helper_1'

logger_init_x

RSpec.describe Mkspec do
  context 'with call methods of Root class' do
    before(:all) do
      conf = TestHelp.make_testconf
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @root = conf._create_instance_of_root
    end

    context 'when extract' do
      it 'call extract_in_hash_with_setting_hash', xcmd: 1 do
        hash = @root.extract_in_hash_with_setting_hash({})
        expect(hash.empty?).to be(false)
      end

      it 'call result', xcmd: 2 do
        ret = @root.result
        expect(ret).not_to be_nil
      end
    end

    context 'when make_item with {}' do
      let(:item) { @root.make_item({}) }

      it 'call make_item', xcmd: 3 do
        expect(item.instance_of?(Mkspec::Item)).to be(true)
      end

      it 'call make_item', xcmd: 4 do
        expect(item.result).not_to be_nil
      end
    end
  end
end
