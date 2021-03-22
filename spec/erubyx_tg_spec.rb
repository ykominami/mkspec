# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Erubyx do
  include UtilHelper
  include TestConf

  let(:original_output_dir_pn) { Pathname.new('_DATA') + 'hier9' }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:target_cmd_1) { 'tecsgen' }
  let(:target_cmd_2) { 'tecsmerge' }
  let(:conf) { TestConf::TestConf.new( target_cmd_1, target_cmd_2, __FILE__, original_output_dir) }
  let(:o) { conf.o }
#add_test_case to_s
  context 'call methods of TestGroup class' do
    before(:each) do
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
      expect(@tg_0.test_cases[size - 1].instance_of?(Erubyx::TestCase)).to eq(true)
      expect(@tg_0.test_cases[size - 1]).to eq(nil)
    end
    it 'call add_test_case_2' , xcmd:3 do
      size = 2
      @conf2.add_testcases(@tg_0, size)
      expect(@tg_0.size).to eq(size)
      expect(@tg_0.test_cases.size).to eq(size)
      expect(@tg_0.test_cases[size - 1].instance_of?(Erubyx::TestCase)).to eq(true)
      expect(@tg_0.test_cases[size - 1]).to eq(nil)
    end
    it 'call add_test_case_3' , xcmd:4 do
      size = 3
      @conf2.add_testcases(@tg_0, size)
      expect(@tg_0.size).to eq(size)
      expect(@tg_0.test_cases.size).to eq(size)
      expect(@tg_0.test_cases[size - 1].instance_of?(Erubyx::TestCase)).to eq(true)
      expect(@tg_0.test_cases[size - 1]).to eq(nil)
    end
=begin
    it 'call setup_from_tsv' , xcmd:2 do
      ret = @tsg.setup_from_tsv
      expect(ret.size).to eq(o.tsv_lines)
    end

    it 'call setup' , xcmd:3 do
      ret = @tsg.setup
      expect(ret.instance_of?(Erubyx::TestScriptGroup)).to eq(true)
    end

    it 'call next_name' , xcmd:4 do
      answer = @tsg.name.succ
      ret = @tsg.next_name
      expect(ret).to eq(answer)
    end

    it 'call result(array of instance of TestScript' , xcmd:5 do
      ret = @tsg.result
      expect(ret.size).to eq(0)
    end

    it 'call result 2' , xcmd:6 do
      ret = @tsg.result
      expect(ret[0].instance_of?(Erubyx::TestScript)).to eq(true)
    end

    it 'call result 3' , xcmd:7 do
      ret = @tsg.result
      expect(ret[0].name).to eq(nil)
    end

    it 'call result 4' , xcmd:8 do
      ret = @tsg.result
      expect(ret[0].script_name).to eq(nil)
    end

    it 'call result 5' , xcmd:9 do
      ret = @tsg.result
      expect(ret[0].test_groups.size).to eq(nil)
    end

    it 'call result 6' , xcmd:9 do
      ret = @tsg.result
      expect(ret[0].test_groups[0]).to eq(nil)
    end
=end
  end
end
