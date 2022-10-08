# frozen_string_literal: true

require 'spec_helper_1'

logger_init( "./logs" )

RSpec.describe Mkspec do
  context 'call methods of Root class' do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      @original_output_dir_pn = @ost.original_output_dir_pn
      @original_output_dir = @ost.original_output_dir
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @root = @conf._create_instance_of_root
    end
    context '' do
      it 'call extract_in_hash_with_setting_hash' , xcmd: 1 do
        hash = @root.extract_in_hash_with_setting_hash({})
        expect(hash.size.zero?).to be(false)
      end

      it 'call result' , xcmd: 2 do
        ret = @root.result
        expect(ret).not_to be_nil
      end
    end

    context 'make_item with {}' do
      before(:all) do
        @item = @root.make_item({})
      end
      it 'call make_item' , xcmd: 3 do
        expect(@item.instance_of?(Mkspec::Item)).to be(true)
      end

      it 'call make_item' , xcmd: 4 do
        expect(@item.result).not_to be_nil
      end
    end
  end
end
