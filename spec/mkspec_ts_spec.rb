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
#
  context 'call methods of TestScript class' do
    before(:each) do
      @conf2 = conf
      @ts_0 = conf.create_instance_of_testscript
      @ts_1 = conf.create_instance_of_testscript
      @ts_2 = conf.create_instance_of_testscript
      @tg_0 = conf.create_instance_of_testgroup_0
      @tg_1 = conf.create_instance_of_testgroup("mruby-mrubybridge", o.make_arg_basename)
      @tg_2 = conf.create_instance_of_testgroup("mruby-mrubybridge2", o.make_arg_basename)
      @tg_3 = conf.create_instance_of_testgroup("mruby-mrubybridge3", o.make_arg_basename)
      @tg_4 = conf.create_instance_of_testgroup("mruby-mrubybridge4", o.make_arg_basename)
      @size_1 = o.limit + 1
      @conf2.add_testcases(@tg_0, @size_1)
      @size_2 = o.limit + 2
      @conf2.add_testcases(@tg_1, @size_2)
      @size_3 = o.limit - 1
      @conf2.add_testcases(@tg_2, @size_3)
      @size_4 = 1
      @conf2.add_testcases(@tg_3, @size_4)
      @size_5 = 3
      @conf2.add_testcases(@tg_4, @size_5)
    end

    it 'call grouping 1' , xcmd:1 do
      ret = @ts_0.grouping(@tg_0)
      expect(@ts_0.total_test_cases).to eq(@size_1)
      expect(@ts_0.test_groups.size).to eq(1)
      expect(ret).to eq(:NOT_EMPTY)
    end

    it 'call grouping 2' , xcmd:2 do
      ret_0 = @ts_0.grouping(@tg_0)
      if ret_0 != :EMPTY
        ret_1 = @ts_1.grouping(@tg_1)
      else
        ret_2 = @ts_0.grouping(@tg_1)
      end
      expect(@ts_0.total_test_cases).to eq(@size_1)
      expect(@ts_0.test_groups.size).to eq(1)
      expect(@ts_1.total_test_cases).to eq(@size_2)
      expect(@ts_1.test_groups.size).to eq(1)
      expect(ret_0).to eq(:NOT_EMPTY)
      expect(@ts_0.inner_result).to eq(:NOT_EMPTY_3)
      expect(ret_1).to eq(:NOT_EMPTY)
      expect(@ts_1.inner_result).to eq(:NOT_EMPTY_3)
      expect(ret_2).to eq(nil)
    end

    it 'call grouping 3' , xcmd:3 do
      ret_0 = @ts_0.grouping(@tg_2)
      ret_1 = @ts_0.grouping(@tg_3)
      expect(@ts_0.total_test_cases).to eq(@size_3 + @size_4)
      expect(@ts_0.test_groups.size).to eq(2)
    end

    it 'call grouping 4' , xcmd:4 do
      ret_0 = @ts_0.grouping(@tg_3)
      ret_1 = @ts_0.grouping(@tg_4)
      expect(@ts_0.total_test_cases).to eq(@size_4 + @size_5)
      expect(@ts_0.test_groups.size).to eq(2)
    end
  end
end
