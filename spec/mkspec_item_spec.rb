# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mkspec do
  include TestConf

  let(:target_cmd_1) { 'tecsgen' }
  let(:target_cmd_2) { 'tecsmerge' }
  let(:conf) { TestConf::TestConf.new( ENV['GLOBAL_YAML_FNAME'], target_cmd_1, target_cmd_2, __FILE__) }
  let(:o) { conf.o }
  let(:original_output_dir_pn) { o.original_output_dir_pn }
  let(:original_output_dir) { o.original_output_dir }

  context 'call methods of Root class' do
    before(:each) do
      @root = conf._create_instance_of_root
      @ret = @root.result
    end

    it 'call result(String)' , xcmd:1 do
#      expect(@ret.instance_of?(String)).to eq(true)
      expect(@ret.class).to eq(String)
    end

    it 'call result' , xcmd:2 do
      expect(@ret.size.zero?).to eq(false)
    end
  end
end
