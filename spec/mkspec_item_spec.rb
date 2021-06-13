# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  include TestConf

  let(:conf) {TestConf::TestConf.new(ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '',  __FILE__, nil) }
  let(:o) { conf.o }
  let(:original_output_dir_pn) { o.original_output_dir_pn }
  let(:original_output_dir) { o.original_output_dir }

  context 'call methods of Root class' do
    before(:each) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
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
