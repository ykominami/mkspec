# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Erubyx do
  include UtilHelper

  let(:spec_pn) { Erubyx::SPEC_PN }
  let(:spec_dir) { spec_pn.to_s }
  let(:tsv_fname) { 'testlist-x.txt' }
  let(:output_dir) { (Pathname.new('_DATA') + 'hier6').to_s }
  let(:test_dir_pn) { spec_pn + "test" }
  let(:_output_dir_pn) { test_dir_pn + '_output' }
  let(:_output_dir) { _output_dir_pn.to_s }
  let(:_test_case_dir_pn) { _output_dir_pn + "_test_case" }
  let(:_test_case_dir) { _test_case_dir_pn.to_s }
  let(:_template_and_data_dir_pn) { _output_dir_pn + "_template_and_data" }
  let(:_template_and_data_dir) { _template_and_data_dir_pn.to_s }
  let(:_script_dir_pn) { _output_dir_pn + "_script" }
  let(:_script_dir) { _script_dir_pn.to_s }
  let(:content_fname) { 'content.txt' }
  let(:testdata_fname) { 'testdata.txt' }
  let(:yaml_fname) { 's4.yml' }
  let(:_yaml_fname) { 'a.yml' }
  let(:_config) { Erubyx::Config.new(spec_dir, _output_dir) }
  let(:_data_dir_pn) { _template_and_data_dir_pn + 'a' }
#
  let(:config_0) { Erubyx::Config.new(spec_dir, output_dir).setup }
#

  let(:tecsgen) { 'tecsgen' }
  let(:cmd) { 'cmd.sh' }
=begin
  let(:test_misc_dir_pn) { "#{test_dir_pn}misc" }
  let(:test_misc_dir) { test_misc_dir_pn.to_s }
=end
  let(:asp_dir) { test_dir_pn+ "asp" + "tecs" }
  let(:asp3_dir) { test_dir_pn + "asp3" }
  let(:tecsmerge_cmd) { 'tecsmerge' }
  let(:start_char) { 'a' }
  let(:limit) { 6 }
  let(:conf) { UtilHelper.make_conf(config_0) }
  let(:test_1) { 'test_1' }
  let(:test_2) { 'test_2' }

  context 'lib' do
    it 'has a version number' do
      expect(Erubyx::VERSION).not_to be nil
    end
  end

  def misc_tsv_fname
    config_0.make_path_under_misc_dir(tsv_fname)
  end

  def _create_instance_of_indenteditem
    tag = 'make_arg_data_flat'
    path = _data_dir_pn + content_fname
    hash = YAML.load_file( _data_dir_pn + _yaml_fname)
    Erubyx::Item.new(tag, path, hash, _config)

    indent = 5
    item = _create_instance_of_item
    #item.load
    Erubyx::IndentedItem.new(indent, item)
  end

  def create_instance_of_config
    Erubyx::Config.new(spec_dir, output_dir).setup
  end

  def _create_instance_of_config
    Erubyx::Config.new(spec_dir, _output_dir)
  end

  def _create_instance_of_config_2
    Erubyx::Config.new(spec_dir, _output_dir, _test_case_dir)
  end

  def create_instance_of_root
    yml_fname = yaml_fname
    yml_path = config_0.make_path_under_misc_dir(yaml_fname)
    Erubyx::Root.new(yml_path, config_0)
  end

  def _create_instance_of_root
    yaml_fname = _yaml_fname
    yaml_path = _config.make_path_under_misc_dir(_yaml_fname)
    Erubyx::Root.new(yaml_path, _config)
  end

  def create_instance_of_item
    tag = 'make_arg_data_flat'
    path = data_dir_pn + content_fname
    hash = {}
    Erubyx::Item.new(tag, path, hash, config_0)
  end

  def _create_instance_of_item
    level = 1
    tag = 'make_arg_data_flat'
    path = _data_dir_pn + content_fname
    hash = YAML.load_file( _data_dir_pn + _yaml_fname)
    Erubyx::Item.new(level, tag, path, hash, _config)
  end

  def create_instance_of_testscript
    name = 'f'
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_setting
    testscript = create_instance_of_testscript
    config = create_instance_of_config
    func_name_of_make_arg = 'make_arg'
    Erubyx::Setting.new(testscript, config, func_name_of_make_arg)
  end

  def create_instance_of_templatex
    setting = create_instance_of_setting
    Erubyx::Templatex.new(setting)
  end

  def create_instance_of_testgroup(tgroup, make_arg_basename)
    Erubyx::TestGroup.new(tgroup, make_arg_basename)
  end

  def create_instance_of_testgroup_0
    make_arg_basename = 'make_arg'
    tgroup_0 = 'mruby-MrubyBridge'
    tgroup = tgroup_0.tr('-', '_').tr('.', '_')
    Erubyx::TestGroup.new(tgroup, make_arg_basename)
  end

  def create_instance_of_testcase
    make_arg_basename = 'make_arg'
    tgroup_0 = 'mruby-MrubyBridge'
    tgroup = tgroup_0.tr('-', '_').tr('.', '_')
    test_group = create_instance_of_testgroup(tgroup, make_arg_basename)
    tcase_0 = '6.2'
    tcase = tcase_0.tr('-', '_').tr('.', '_')
    test_1 = nil
    test_2 = nil
    extra = nil
    Erubyx::TestCase.new(test_group, tcase, test_1, test_2, extra)
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
    make_arg_basename = 'make_arg'
    Erubyx::TestScriptGroup.new(fname, start_char, limit, make_arg_basename)
  end

  def create_instance_of_testscript
    name = 'f'
    limit = 5
    Erubyx::TestScript.new(name, limit)
  end

  def create_instance_of_mkscript(argv)
    Erubyx::Mkscript.new(argv)
  end

  def create_instance_of_indenteditem()
    indent = 5
    item = create_instance_of_item()
    Erubyx::IndentedItem.new(indent, item)
  end

  context 'IndenteedItem expand' do
    before(:each) do
      path = _data_dir_pn + testdata_fname
      item = _create_instance_of_indenteditem
    end
  end

  context 'Item expand' do
    before(:each) do
      path = _data_dir_pn + testdata_fname

      item = _create_instance_of_item
      item.load
      @state_1 = item.state
      @content_lines = item.content_lines
      @path = item.path.to_s
      @tag = item.tag
      @hash = item.hash[@tag]
      @size = item.tag_table[@tag]
      item.to_s_1
      @state_2 = item.state
      item.add_indent(item.tag, item.size)
      @content = item.content
      @state_3 = item.state
      @extract_count = item.extract_count
      @testdata = File.read(path)
    end

    it 'extract_count' , state:true do
      expect(@extract_count).to eq(nil)
    end

    it 'state_1' , state:true do
      expect(@state_1).to eq(nil)
    end

    it 'state_2' , state:true do
      expect(@state_2).to eq(nil)
    end

    it 'state_3' , state:true do
      expect(@state_3).to eq(nil)
    end

    it 'content-1' , state:true do
      expect(@content).to eq(nil)
    end

    it 'size' do
      expect(@size).to eq(nil)
    end

    it 'content_lines' do
      expect(@content_lines).to eq(nil)
    end

    it 'expand content' do
#      expect(@expand).to eql(@testdata)
      expect(@expand).to eq(@testdata)
#      expect(@expand).to include(@testdata)
#      expect(@expand).to equal(@testdata)
    end

    it 'content_lines' do
      expect(@content_lines).to eq(nil)
    end

    it 'path' do
      expect(@path).to eq(nil)
    end

    it 'tag' do
      expect(@tag).to eq(nil)
    end

    it 'hash' do
      expect(@hash).to eq(nil)
    end
  end

  context 'IntendedItem expand' do
    before(:each) do
      path = _data_dir_pn + testdata_fname

      indenteditem = _create_instance_of_indenteditem
      @expand = indenteditem.expand.result
      @testdata = File.read(path)
    end
    it 'expand content' do
#      expect(@expand).to eql(@testdata)
      expect(@expand).to eq(@testdata)
#      expect(@expand).to include(@testdata)
#      expect(@expand).to equal(@testdata)
    end
  end

  context 'create instance of class' do
    context 'IndentedItem' do
      before(:each) do
        @indenteditem = _create_instance_of_indenteditem
      end
      it 'create instance IndentedItem' do
        expect(@indenteditem).not_to eq(nil)
      end
    end

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
