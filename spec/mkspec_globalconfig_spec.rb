# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  include Mkspec::Misc

  context 'call methods of ' do
    before(:each) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      specific_yaml = ENV['MKSPEC_SPECIFIC_YAML_FNAME']
      global_yaml = ENV['MKSPEC_GLOBAL_YAML_FNAME']
      target_cmd_1 = "tecsgen"
      target_cmd_2 = "tecsmerge"
      original_spec_file_path = __FILE__
      dump_var(:specifix_yaml, specific_yaml )
      top_dir = nil
      @ret = Mkspec::GlobalConfig.new(specific_yaml, global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path, top_dir)
    end

    it 'ret' , xcmd:1 do
#      expect(@ret.instance_of?(String)).to eq(true)
      expect(@ret.class).to eq(Mkspec::GlobalConfig)
    end
  end
end
