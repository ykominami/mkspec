# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  context 'call instance methods of TestScript class' do
    before(:all) do
      @conf = Mkspec::TestConf.new( ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '',  __FILE__, nil)
      @o = @conf.o
      @original_output_dir_pn = @o.original_output_dir_pn
      @original_output_dir = @o.original_output_dir
    end
    context '' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @conf2 = @conf
        @ts_0 = @conf.create_instance_of_testscript
        @ts_1 = @conf.create_instance_of_testscript
        @ts_2 = @conf.create_instance_of_testscript
        @tg_0 = @conf.create_instance_of_testgroup_0
        @tg_1 = @conf.create_instance_of_testgroup("mruby-mrubybridge", @o.make_arg_basename)
        @tg_2 = @conf.create_instance_of_testgroup("mruby-mrubybridge2", @o.make_arg_basename)
        @tg_3 = @conf.create_instance_of_testgroup("mruby-mrubybridge3", @o.make_arg_basename)
        @tg_4 = @conf.create_instance_of_testgroup("mruby-mrubybridge4", @o.make_arg_basename)
        @size_1 = @o.limit + 1
      end

      context 'call grouping 1' do
        before(:all) do
          @ret = @ts_0.grouping(@tg_0)
        end
        it '1' , xcmd:1 do
          expect(@ts_0.total_test_cases).to eq(@tg_0.size)
        end
        it '2' , xcmd:2 do
          expect(@ts_0.test_groups.size).to eq(1)
        end
        it '3' , xcmd:3 do
          expect(@ret).to eq(:NOT_EMPTY)
        end
      end

      context 'call grouping 2' do
        before(:all) do
          @ret_0 = @ts_0.grouping(@tg_0)
          if @ret_0 != :EMPTY
            @ret_1 = @ts_1.grouping(@tg_1)
          else
            @ret_2 = @ts_0.grouping(@tg_1)
          end
          @size_1 = @ts_0.total_test_cases
          @size_2 = @ts_1.total_test_cases
        end
        it '1' , cmd:2  do
          expect(@ts_0.total_test_cases).to eq(@tg_0.size)
        end
        it '2' do
          expect(@ts_1.total_test_cases).to eq(@tg_1.size)
        end
        it '' do
          expect(@ts_1.test_groups.size).to eq(1)
        end
        it '' do
          expect(@ret_0).to eq(:NOT_EMPTY)
        end
        it '' do
          expect(@ts_0.inner_result).to eq(:NOT_EMPTY_2)
        end
        it '' do
          expect(@ret_1).to eq(:NOT_EMPTY)
        end
        it '' do
          expect(@ts_1.inner_result).to eq(:NOT_EMPTY_2)
        end
        it '' do
          expect(@ret_2).to eq(nil)
        end
      end

      context 'call grouping 3' do
        before(:all) do
          @size_3 = @tg_2.size
          ret_0 = @ts_0.grouping(@tg_2)
          @size_4 = @tg_3.size
          ret_1 = @ts_0.grouping(@tg_3)
        end
        it '' , xcmd:3 do
          expect(@ts_0.total_test_cases).to eq(@size_3 + @size_4)
        end
        it '' do
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
        it '' , xcmd:4 do
          expect(@ts_0.total_test_cases).to eq(@size_4 + @size_5)
        end
        it '' do
          expect(@ts_0.test_groups.size).to eq(6)
        end
      end
    end
  end
end
