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
#
  context 'call method of TestScriptGroup class' do
    before(:each) do
      @tsg = conf.create_instance_of_testscriptgroup
    end
    it 'call setup_test_group' , xcmd:1 do
#      l = ""
#      l = "data-normal"
#      l = "data-normal	com.1"
#      l = "data-normal	com.1 to  be_successfully_executeds_y not_to  have_output(/error:/)x"
#      l = "data-normal\tcom.1\tto\tbe_successfully_executeds_y\tnot_to\thave_output(/error:/)x"
#      l = "data-normal\tcom.1\ttest_1\t :to s\ttest_2\t:not_to xyz\te1\tre5"
      l = "data-normal\tcom.1\ttest_1"
      hash = {}
      ret = @tsg.setup_test_group(l, hash)
#      answer = "data_normal"

#      expect(ret).to eq(nil)
#      expect(ret).to eq(answer)
      expect(ret.instance_of?(Erubyx::TestCaseGroup)).to eq(true)
#      expect(ret).to_not eq(nil)
#      expect(hash).to eq(nil)
    end

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
  end
end
