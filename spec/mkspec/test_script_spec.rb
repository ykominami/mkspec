# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec::TestScript do
  context 'call instance methods of TestScript class' do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      @original_output_dir_pn = @ost.original_output_dir_pn
      @original_output_dir = @ost.original_output_dir
    end
    context 'TestScript' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @conf2 = @conf
        @ts_0 = @conf.create_instance_of_testscript
        @ts_1 = @conf.create_instance_of_testscript
        @ts_2 = @conf.create_instance_of_testscript
        @tg_0 = @conf.create_instance_of_testgroup_0
        @tg_1 = @conf.create_instance_of_testgroup("mruby-mrubybridge", @ost.make_arg_basename)
        @tg_2 = @conf.create_instance_of_testgroup("mruby-mrubybridge2", @ost.make_arg_basename)
        @tg_3 = @conf.create_instance_of_testgroup("mruby-mrubybridge3", @ost.make_arg_basename)
        @tg_4 = @conf.create_instance_of_testgroup("mruby-mrubybridge4", @ost.make_arg_basename)
        @size_1 = @ost.limit + 1
      end

      context 'call grouping 1' do
        before(:all) do
          @ret = @ts_0.grouping(@tg_0)
        end
        it 'total_test_case of TestScript_0 size equal size of TestScriptGroup_0' , xcmd: 1 do
          expect(@ts_0.total_test_cases).to eq(@tg_0.size)
        end

        it 'Size of TestGroup of TestScript_0 equal size of TestScriptGroup_0' , xcmd: 2 do
          expect(@ts_0.test_groups.size).to eq(1)
        end

        it 'TestScript_0 is grouping of TestGroup_0 is not empty' , xcmd: 3 do
          expect(@ret).to eq(:NOT_EMPTY)
        end
      end

      context 'TestScript_0 is grouping of TestGroup_0' do
        before(:all) do
          @ret_0 = @ts_0.grouping(@tg_0)
          if @ret_0 == :EMPTY
            @ret_2 = @ts_0.grouping(@tg_1)
          else
            @ret_1 = @ts_1.grouping(@tg_1)
          end
          @size_1 = @ts_0.total_test_cases
          @size_2 = @ts_1.total_test_cases
        end
        it 'Total test cases of TestScript_0 equals to size of TestGroup_0' , cmd: 2 do
          expect(@ts_0.total_test_cases).to eq(@tg_0.size)
        end

        it 'Total test cases of TestScipt_1 equals size of TestGroup_1' do
          expect(@ts_1.total_test_cases).to eq(@tg_1.size)
        end

        it 'Size of Test Group of TestScript_1 equals to 1' do
          expect(@ts_1.test_groups.size).to eq(1)
        end

        it 'TestScript_0 is grouping of TestGroup_0 is executing successfly' do
          expect(@ret_0).to eq(:NOT_EMPTY)
        end

        it 'Inner result of TestScript_0 does not get empty' do
          expect(@ts_0.inner_result).to eq(:NOT_EMPTY_2)
        end

        it 'TestScript_1 is grouping TestGroup_1 does not get empty' do
          expect(@ret_1).to eq(:NOT_EMPTY)
        end

        it 'Inner result of TestScript_1 does not get empty' do
          expect(@ts_1.inner_result).to eq(:NOT_EMPTY_2)
        end

        it 'TestScript_0 is grouping of TestGroup_1 is executing successfly' do
          expect(@ret_2).to be_nil
        end
      end

      context 'call grouping 3' do
        before(:all) do
          @size_3 = @tg_2.size
          ret_0 = @ts_0.grouping(@tg_2)
          @size_4 = @tg_3.size
          ret_1 = @ts_0.grouping(@tg_3)
        end
        it 'Total test cases of TestScript_0 equals to sum of TestGroup_2 and TestGroup_3' , xcmd: 3 do
          expect(@ts_0.total_test_cases).to eq(@size_3 + @size_4)
        end

        it 'Size of Test Groups of TestScript_0 equals to 4' do
          expect(@ts_0.test_groups.size).to eq(4)
        end
      end

      context 'call grouping 4' do
        before(:all) do
          @ret_0 = @ts_0.grouping(@tg_3)
          @ret_1 = @ts_0.grouping(@tg_4)
          @size_4 = @tg_3.size
          @size_5 = @tg_4.size
        end
        it 'Total test cases of TestScript_0 equals to sum of size of TestGroup_3 and size of TestGroup_4' , xcmd: 4 do
          expect(@ts_0.total_test_cases).to eq(@size_4 + @size_5)
        end

        it 'Size of Test Groups of TestScript_0 equals to 6' do
          expect(@ts_0.test_groups.size).to eq(6)
        end
      end
    end
  end
end
