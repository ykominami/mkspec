# frozen_string_literal: true

require 'spec_helper'

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

    it 'call result' , xcmd:1 do
      ret = @root.result
      expect(ret.instance_of?(String)).to eq(true)

      expect(ret.size.zero?).to eq(false)
    end
  end
end
