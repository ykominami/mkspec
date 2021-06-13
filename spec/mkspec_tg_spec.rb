# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  include TestConf

  let(:target_cmd_1) { 'tecsgen' }
  let(:target_cmd_2) { 'tecsmerge' }
  let(:conf) { TestConf::TestConf.new( ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '', __FILE__, nil) }
  let(:o) { conf.o }
  let(:original_output_dir_pn) { o.original_output_dir_pn }
  let(:original_output_dir) { o.original_output_dir }

  context 'call methods of TestGroup class' do
    before(:each) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @conf2 = conf
      @tg_0 = conf.create_instance_of_testgroup_0
      @tg_0_name_normalize = o.tgroup_0_name_normalize
#      @tg_1 = conf.create_instance_of_testgroup("mruby-mrubybridge", o.make_arg_basename)
    end
    it 'call to_s' , xcmd:1 do
      ret = @tg_0.to_s
      expect(ret).to eq(@tg_0_name_normalize)
    end
    it 'call add_test_case_1' , xcmd:2 do
      size = 1
      @conf2.add_testcases(@tg_0, size)
      expect(@tg_0.size).to eq(size)
      expect(@tg_0.test_cases.size).to eq(size)
      expect(@tg_0.test_cases[size - 1].instance_of?(Mkspec::TestCase)).to eq(true)
    end
    it 'call add_test_case_2' , xcmd:3 do
      size = 2
      @conf2.add_testcases(@tg_0, size)
      expect(@tg_0.size).to eq(size)
      expect(@tg_0.test_cases.size).to eq(size)
      expect(@tg_0.test_cases[size - 1].instance_of?(Mkspec::TestCase)).to eq(true)
    end
    it 'call add_test_case_3' , xcmd:4 do
      size = 3
      @conf2.add_testcases(@tg_0, size)
      expect(@tg_0.size).to eq(size)
      expect(@tg_0.test_cases.size).to eq(size)
      expect(@tg_0.test_cases[size - 1].instance_of?(Mkspec::TestCase)).to eq(true)
    end
  end
end
