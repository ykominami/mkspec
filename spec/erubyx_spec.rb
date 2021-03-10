# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Erubyx do
  include UtilHelper

  let(:spec_pn){Pathname.new(__FILE__).parent}
  let(:yml_fname){''}

  let(:tecsgen) {'tecsgen'}
  let(:cmd){'cmd.sh'}
  let(:top_pn){Pathname.new( ENV['PWD'] )}
  let(:test_data_dir_pn){spec_pn + 'test_data' + '_DATA'}
  let(:test_data_dir){test_data_dir_pn.to_s}
  let(:test_case_dir){(test_data_dir_pn + 'test_case').to_s}
  let(:asp_dir){"/mnt/v/ext2/svn-tecs/asp+tecs"}
  let(:asp3_dir){"/mnt/v/ASP/ASP3/asp3_arm_gcc-20191006.tar/asp3"}
  let(:tecsmerge_cmd){'tecsmerge'}
  let(:result){'result.txt'}
  let(:conf){UtilHelper.set_conf(top_pn, test_data_dir, test_case_dir, tecsgen, tecsmerge_cmd, cmd_pn)}
  let(:test_1){'test_1'}
  let(:test_2){'test_2'}
  let(:test_data_yaml_fname) {'s4.yml'}
  let(:data_fname) {"testlist.txt"}

  before(:all){
    ENV['TECSPATH'] = @tecspath.to_s
  }
  context 'lib' do
    it 'has a version number' do
      expect(Erubyx::VERSION).not_to be nil
    end
  end

  def create_instance_of_Root
    yml_fname = (test_data_dir_pn + test_data_yaml_fname).to_s
    @root = Erubyx::Root.new(yml_fname, test_data_dir)
  end

  def create_instance_of_Item
    level = 1
    tag = "path"
    path = "t4/content.txt"
    hash = {}
    Erubyx::Item.new(level, tag, path, hash, test_data_dir_pn)
  end

  def create_instance_of_typescript
    name = "f"
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_setting
    testscript = create_instance_of_typescript
    make_arg = "make_arg"
    Erubyx::Setting.new(testscript, test_data_dir_pn, make_arg)
  end

  def create_instance_of_templatex
    setting = create_instance_of_setting
    @templatex = Erubyx::Templatex.new(setting)
  end

  def create_instance_of_testgroup
    make_arg = "make_arg"
    tgroup0 = "mruby-MrubyBridge"
    tgroup = tgroup0.tr('-', '_').tr('.', '_')
    Erubyx::TestGroup.new(tgroup, make_arg)
  end

  def create_instance_of_testcase
    test_group = creaet_instance_of_testgroup
    tcase0 = "6.2"
    tcase = tcase0.tr('-', '_').tr('.', '_')
    extra = nil
    @testcase = Erubyx::TestCase.new(test_group, tgroup, tcase, make_arg, test_1, test_2, extra)
  end

  def create_instance_of_testcase
    name = "f"
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_testscriptgroup
    fname = (test_data_dir_pn + data_fname).to_s
    start_char = 'f'
    limit = 5
    make_arg = "make_arg"
    Erubyx::TestScriptGroup.new(fname, start_char, limit, make_arg)
  end

  def create_instance_of_testscript
    name = "f"
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_mkscript
    fname = (test_data_dir_pn + data_fname).to_s
    start_char = 'f'
    limit = 5
    make_arg = "make_arg"
    Erubyx::Mkscript.new(fname, start_char, limit, make_arg)
  end

  context 'class instance' do
    context 'Root' do
      before(:each) {
        @root = create_instance_of_Root()
      }
      it 'create instance' do
        expect(@root).not_to eq(nil)
      end
    end

    context 'Item' do
      before(:each) {
        @item = create_instance_of_Item
      }
      it 'create instance' do
        expect(@item).not_to eq(nil)
      end
    end

    context 'Setting' do
      before(:each) {
        @setting = create_instance_of_setting
      }
      it 'create instance' do
        expect(@setting).not_to eq(nil)
      end
    end

    context 'Templatex' do
      before(:each) {
        @templatex = create_instance_of_templatex
      }
      it 'create instance' do
        expect(@templatex).not_to eq(nil)
      end
    end

    context 'TestGroup' do
      before(:each) {
        @testgroup = create_instance_of_testgroup
      }
      it 'create instance' do
        expect(@testgroup).not_to eq(nil)
      end
    end

    context 'TestCase' do
      before(:each) {
        @testcase = create_instance_of_testcase
      }
      it 'create instance' do
        expect(@testcase).not_to eq(nil)
      end
    end

    context 'TestScript' do
      before(:each) {
        @testscript = create_instance_of_testscript
      }
      it 'create instance' do
        expect(@testscript).not_to eq(nil)
      end
    end

    context 'TestScriptGroup' do
      before(:each) {
        @testscriptgroup = create_instance_of_testscriptgroup
      }
      it 'create instance' do
        expect(@testscriptgroup).not_to eq(nil)
      end
    end

    context 'Mkscript' do
      before(:each) {
        @mkscript = create_instance_of_mkscript
      }
      it 'create instance' do
        expect(@mkscript).not_to eq(nil)
      end
    end
  end
end

