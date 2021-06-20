# frozen_string_literal: true

require 'spec_helper_1'
require 'pp'

RSpec.describe Mkspec do
  context 'call methods of Root class' do
    before(:all) do
      @conf = Mkspec::TestConf.new( ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '', __FILE__, nil)
      @o = @conf.o
      @original_output_dir_pn = @o.original_output_dir_pn
      @original_output_dir = @o.original_output_dir
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @root = @conf._create_instance_of_root
    end
    context '' do
      it 'call extract_in_hash_with_setting_hash' , xcmd:1 do
        hash = @root.extract_in_hash_with_setting_hash({})
        expect(hash.size.zero?).to eq(false)
      end

      it 'call result' , xcmd:4 do
        ret = @root.result
        expect(ret).to eq(nil)
      end
    end

    context 'make_item with {}' do
      before(:all) do
        @item = @root.make_item({})
      end
      it 'call make_item' , xcmd:2 do
        expect(@item.instance_of?(Mkspec::Item)).to eq(true)
      end

      it 'call make_item' , xcmd:3 do
        expect(@item.result).to eq(nil)
      end
    end
  end
end
