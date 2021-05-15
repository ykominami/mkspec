# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mkspec do
  include TestConf

  let(:original_output_dir_pn) { Pathname.new('_DATA') + 'hier9' }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:target_cmd_1) { 'tecsgen' }
  let(:target_cmd_2) { 'tecsmerge' }
  let(:conf) { TestConf::TestConf.new( ENV['GLOBAL_YAML_FNAME'], target_cmd_1, target_cmd_2, __FILE__, original_output_dir) }
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
      expect(ret.instance_of?(Mkspec::TestScriptGroup)).to eq(true)
#      expect(ret).to_not eq(nil)
#      expect(hash).to eq(nil)
    end

    it 'call setup_from_tsv' , xcmd:2 do
      ret = @tsg.setup_from_tsv
      expect(ret.size).to eq(o.number_of_testgroup)
      expect(ret.instance_of?(Hash)).to eq(true)
    end

    it 'call setup' , xcmd:3 do
      ret = @tsg.setup
      expect(ret.instance_of?(Mkspec::TestScriptGroup)).to eq(true)
    end

    it 'call next_name' , xcmd:4 do
      answer = @tsg.name.succ
      ret = @tsg.next_name
      expect(ret).to eq(answer)
    end

    context 'call result after calling setup' do
      before(:each) do
        @number_of_testscript = o.number_of_testscript
        @start_char = o.start_char
        @tsg = conf.create_instance_of_testscriptgroup
        @first_script_name = conf.make_script_name(@start_char)
        @number_of_testgroup_of_first_testscript = o.number_of_testgroup_of_first_testscript
        @tsg.setup
        @ret = @tsg.result
      end

      it 'call result(array of instance of TestScript' , xcmd:5 do
        expect(@ret.size).to eq(@number_of_testscript)
      end

      it 'call result 2' , xcmd:6 do
        expect(@ret[0].instance_of?(Mkspec::TestScript)).to eq(true)
      end

      it 'call result 3' , xcmd:7 do
        expect(@ret[0].name).to eq(@start_char)
      end

      it 'call result 4' , xcmd:8 do
        expect(@ret[0].script_name).to eq(@first_script_name)
      end

      it 'call result 5' , xcmd:9 do
        expect(@ret[0].test_groups.size).to eq(@number_of_testgroup_of_first_testscript)
      end

      it 'call result 6' , xcmd:10 do
        expect(@ret[0].test_groups[0].instance_of?(Mkspec::TestGroup)).to eq(true)
      end
    end
  end
end
