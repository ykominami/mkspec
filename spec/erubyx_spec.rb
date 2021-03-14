# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Erubyx do
  include UtilHelper

  let(:spec_pn) { Erubyx::SPEC_PN }
  let(:spec_dir) { spec_pn.to_s }
  let(:yaml_fname) { 's4.yml' }

  let(:tecsgen) { 'tecsgen' }
  let(:cmd) { 'cmd.sh' }
  let(:test_dir_pn) { spec_pn + "test" }
  let(:output_dir) { (Pathname.new('_DATA') + 'hier5').to_s }
=begin

  let(:test_misc_dir_pn) { "#{test_dir_pn}misc" }
  let(:test_misc_dir) { test_misc_dir_pn.to_s }
  let(:test_case_dir_pn) { "#{test_dir_pn}test_case" }
  let(:test_case_dir) { test_case_dir_pn.to_s }
=end
  let(:asp_dir) { test_dir_pn+ "asp" + "tecs" }
  let(:asp3_dir) { test_dir_pn + "asp3" }
  let(:tecsmerge_cmd) { 'tecsmerge' }
  let(:result) { 'result.txt' }
  let(:start_char) { 'a' }
  let(:limit) { 6 }
#  let(:top_pn) { Pathname.new(ENV['PWD']) }
#  let(:conf) { UtilHelper.make_conf(top_pn, output_dir, test_case_dir, cmd, tecsgen, tecsmerge_cmd) }
  let(:conf) { UtilHelper.make_conf(config_0) }
  let(:test_1) { 'test_1' }
  let(:test_2) { 'test_2' }
  let(:tsv_fname) { 'testlist-x.txt' }
  let(:config_0) { Erubyx::Config.new(spec_dir, output_dir) }

  context 'lib' do
    it 'has a version number' do
      expect(Erubyx::VERSION).not_to be nil
    end
  end

  def misc_tsv_fname
    config_0.make_path_under_misc_dir(tsv_fname)
  end

  def create_instance_of_config
    Erubyx::Config.new(spec_dir, output_dir)
  end

  def create_instance_of_config_2
    Erubyx::Config.new(output_dir, test_case_dir)
  end

  def create_instance_of_root
    yml_fname = yaml_fname
    yml_path = config_0.make_path_under_misc_dir(yaml_fname)
    Erubyx::Root.new(yml_path, config_0)
  end

  def create_instance_of_item
    level = 1
    tag = 'path'
    path = 't4/content.txt'
    hash = {}
    Erubyx::Item.new(level, tag, path, hash, config_0)
  end

  def create_instance_of_testscript
    name = 'f'
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_setting
    testscript = create_instance_of_testscript
    config = create_instance_of_config
    make_arg = 'make_arg'
    Erubyx::Setting.new(testscript, config, make_arg)
  end

  def create_instance_of_templatex
    setting = create_instance_of_setting
    Erubyx::Templatex.new(setting)
  end

  def create_instance_of_testgroup(tgroup, make_arg)
    Erubyx::TestGroup.new(tgroup, make_arg)
  end

  def create_instance_of_testgroup_0
    make_arg = 'make_arg'
    tgroup_0 = 'mruby-MrubyBridge'
    tgroup = tgroup_0.tr('-', '_').tr('.', '_')
    Erubyx::TestGroup.new(tgroup, make_arg)
  end

  def create_instance_of_testcase
    make_arg = 'make_arg'
    tgroup_0 = 'mruby-MrubyBridge'
    tgroup = tgroup_0.tr('-', '_').tr('.', '_')
    test_group = create_instance_of_testgroup(tgroup, make_arg)
    tcase_0 = '6.2'
    tcase = tcase_0.tr('-', '_').tr('.', '_')
    test_1 = nil
    test_2 = nil
    extra = nil
    Erubyx::TestCase.new(test_group, tgroup, tcase, make_arg, test_1, test_2, extra)
  end

  def create_instance_of_testscript
    name = 'f'
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_testscriptgroup
    fname = misc_tsv_fname
    start_char = 'f'
    limit = 5
    make_arg = 'make_arg'
    Erubyx::TestScriptGroup.new(fname, start_char, limit, make_arg)
  end

  def create_instance_of_testscript
    name = 'f'
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_mkscript(argv)
    Erubyx::Mkscript.new(argv)
  end

  def create_instance_of_mkspec(argv)
    Erubyx::Mkspec.new(argv)
  end

  context 'create instance of class' do
    context 'Config' do
      before(:each) do
        @config = create_instance_of_config
      end
      it 'create instance' do
        expect(@config).not_to eq(nil)
      end
    end

    context 'Root' do
      before(:each) do
        @root = create_instance_of_root
      end
      it 'create instance' do
        expect(@root).not_to eq(nil)
      end
    end

    context 'Item' do
      before(:each) do
        @item = create_instance_of_item
      end
      it 'create instance' do
        expect(@item).not_to eq(nil)
      end
    end

    context 'Setting' do
      before(:each) do
        @setting = create_instance_of_setting
      end
      it 'create instance' do
        expect(@setting).not_to eq(nil)
      end
    end

    context 'Templatex' do
      before(:each) do
        @templatex = create_instance_of_templatex
      end
      it 'create instance' do
        expect(@templatex).not_to eq(nil)
      end
    end

    context 'TestGroup' do
      before(:each) do
        @testgroup = create_instance_of_testgroup_0
      end
      it 'create instance' do
        expect(@testgroup).not_to eq(nil)
      end
    end

    context 'TestCase' do
      before(:each) do
        @testcase = create_instance_of_testcase
      end
      it 'create instance' do
        expect(@testcase).not_to eq(nil)
      end
    end

    context 'TestScript' do
      before(:each) do
        @testscript = create_instance_of_testscript
      end
      it 'create instance' do
        expect(@testscript).not_to eq(nil)
      end
    end

    context 'TestScriptGroup' do
      before(:each) do
        @testscriptgroup = create_instance_of_testscriptgroup
      end
      it 'create instance' do
        expect(@testscriptgroup).not_to eq(nil)
      end
    end

    context 'Mkscript' do
      before(:each) do
        tsv_fname = misc_tsv_fname
        argv = %W[-d #{output_dir} -t #{tsv_fname} -c all -s #{start_char} -l #{limit}]
        @mkscript = create_instance_of_mkscript(argv)
      end
      it 'create instance' do
        expect(@mkscript).not_to eq(nil)
      end
    end
  end

  context 'make script' do
    context 'Mkscript-a' do
      before(:each) do
        tsv_fname = misc_tsv_fname
        argv = %W[-d #{output_dir} -t #{tsv_fname} -c all -s #{start_char} -l #{limit}]
        @mkscript = create_instance_of_mkscript(argv)

        @ret = @mkscript.do_process
      end
      it 'create instance' do
        expect(@ret).to eq true
      end
    end

    context 'Mkscript-p' do
      before(:each) do
        tsv_fname = misc_tsv_fname
        argv = %W[-d #{output_dir} -t #{tsv_fname} -c partial -s #{start_char} -l #{limit}]
        @mkscript = create_instance_of_mkscript(argv)

        @ret = @mkscript.do_process
      end
      it 'create instance' do
        expect(@ret).to eq true
      end
    end
  end
end
