# frozen_string_literal: true

require 'spec_helper'
require 'pp'

RSpec.describe Mkspec do
  include TestConf

  let(:original_output_dir_pn) { Pathname.new('_DATA') + 'hier9' }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:target_cmd_1) { 'tecsgen' }
  let(:target_cmd_2) { 'tecsmerge' }
  let(:conf) { TestConf::TestConf.new( ENV['GLOBAL_YAML'], target_cmd_1, target_cmd_2, __FILE__, original_output_dir) }
  let(:o) { conf.o }

  context 'call methods of Root class' do
    before(:each) do
      @root = conf._create_instance_of_root
    end

    it 'call extract_in_hash' , xcmd:1 do
      hash = @root.extract_in_hash({})
      expect(hash.size.zero?).to eq(false)
    end

    it 'call make_item' , xcmd:2 do
      item = @root.make_item({})
      expect(item.instance_of?(Mkspec::Item)).to eq(true)
    end

    it 'call make_item' , xcmd:3 do
      item = @root.make_item({})
      expect(item.result.instance_of?(String)).to eq(true)
    end

    it 'call result' , xcmd:4 do
      ret = @root.result
      expect(ret.instance_of?(String)).to eq(true)
    end
  end
end
