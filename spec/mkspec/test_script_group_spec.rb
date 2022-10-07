# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec::TestScriptGroup do
  context '' do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      @original_output_dir_pn = @ost.original_output_dir_pn
      @original_output_dir = @ost.original_output_dir
    end
    context 'call method of TestScriptGroup class' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @tsg = @conf.create_instance_of_testscriptgroup
      end
      it 'call setup_test_group' , xcmd: 1 do
        l = "data-normal\tcom.1\ttest_1"
        hash = {}
        ret = @tsg.setup_test_group(l, hash)
        expect(ret.instance_of?(described_class)).to be(true)
      end

      context 'setup_from_tsv' do
        before(:all) do
          @ret = @tsg.setup_from_tsv
        end
        it 'call setup_from_tsv' , xcmd: 2 do
          expect(@ret.size).to eq(@ost.number_of_testgroup)
        end

        it 'Hash' do
          expect(@ret.instance_of?(Hash)).to be(true)
        end
      end

      it 'call setup' , xcmd: 3 do
        ret = @tsg.setup
        expect(ret.instance_of?(described_class)).to be(true)
      end

      it 'call next_name' , xcmd: 4 do
        answer = @tsg.name.succ
        ret = @tsg.next_name
        expect(ret).to eq(answer)
      end

      context 'call result after calling setup' do
        before(:all) do
          Mkspec::STATE.change(Mkspec::SUCCESS, nil)
          @number_of_testscript = @ost.number_of_testscript
          @start_char = @ost.start_char
          @tsg = @conf.create_instance_of_testscriptgroup
          @first_script_name = @conf.make_script_name(@start_char)
          @number_of_testgroup_of_first_testscript = @ost.number_of_testgroup_of_first_testscript
          @tsg.setup
          @ret = @tsg.result
        end

        it 'call result(array of instance of TestScript' , xcmd: 5 do
          expect(@ret.size).to eq(@number_of_testscript)
        end

        it 'call result 2' , xcmd: 6 do
          expect(@ret[0].instance_of?(Mkspec::TestScript)).to be(true)
        end

        it 'call result 3' , xcmd: 7 do
          expect(@ret[0].name).to eq(@start_char)
        end

        it 'call result 4' , xcmd: 8 do
          expect(@ret[0].script_name).to eq(@first_script_name)
        end

        it 'call result 5' , xcmd: 9 do
          expect(@ret[0].test_groups.size).to eq(@number_of_testgroup_of_first_testscript)
        end

        it 'call result 6' , xcmd: 10 do
          expect(@ret[0].test_groups[0].instance_of?(Mkspec::TestGroup)).to be(true)
        end
      end
    end
  end
end
