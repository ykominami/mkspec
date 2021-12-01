# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Erubyx do
  include UtilHelper
  include TestConf

#  let(:original_spec_pn) { Pathname.new(__FILE__).parent }
#  let(:original_spec_dir) { original_spec_pn.to_s }
  let(:original_output_dir_pn) { Pathname.new('_DATA') + 'hier9' }
  let(:original_output_dir) { original_output_dir_pn.to_s }
#  let(:conf) { TestConf::TestConf.new( original_spec_dir, original_output_dir) }
  let(:conf) { TestConf::TestConf.new( __FILE__, original_output_dir) }
  let(:o) { conf.o }
#
  context 'format' do
    before(:each) do
      str=<<EOS
      class A
def initialize()
end

def m1
end
end
EOS
      @ret = Erubyx::Mkscript.format(str)
      format_pn = o._test_data_dir_pn + o.format_fname
      @value = File.read(format_pn)
    end

    it 'format' , f:true do
      expect(@ret).to eq(@value)
    end
  end

  context 'create instance of class' do
    context 'Config' do
      before(:each) do
        @config = conf.create_instance_of_config
      end
      it 'create instance' , ci:1 do
        expect(@config).not_to eq(nil)
      end
    end

    context 'Root' do
      before(:each) do
        @root = conf.create_instance_of_root
      end
      it 'create instance' , ci:2 do
        expect(@root).not_to eq(nil)
      end
    end

    context 'Item' do
      before(:each) do
        content_path = o.data_dir_pn + o.content_fname
        yaml_path = o.data_dir_pn + o.yaml_fname
        Erubyx::Loggerxcm.debug "content_path=#{content_path}"
        Erubyx::Loggerxcm.debug "yaml_path=#{yaml_path}"
        @item = conf.create_instance_of_item(content_path, yaml_path)
      end
      it 'create instance' , ci:3 do
        expect(@item).not_to eq(nil)
      end
    end

    context 'Setting' do
      before(:each) do
        @setting = conf.create_instance_of_setting
      end
      it 'create instance' , ci:4 do
        expect(@setting).not_to eq(nil)
      end
    end

    context 'Templatex' do
      before(:each) do
        @templatex = conf.create_instance_of_templatex
      end
      it 'create instance' , ci:5 do
        expect(@templatex).not_to eq(nil)
      end
    end

    context 'TestGroup' do
      before(:each) do
        @testgroup = conf.create_instance_of_testgroup_0
      end
      it 'create instance' , ci:6 do
        expect(@testgroup).not_to eq(nil)
      end
    end

    context 'TestCase' do
      before(:each) do
        @testcase = conf.create_instance_of_testcase
      end
      it 'create instance' , ci:7 do
        expect(@testcase).not_to eq(nil)
      end
    end

    context 'TestScript' do
      before(:each) do
        @testscript = conf.create_instance_of_testscript
      end
      it 'create instance' , ci:8 do
        expect(@testscript).not_to eq(nil)
      end
    end

    context 'TestScriptGroup' do
      before(:each) do
        @testscriptgroup = conf.create_instance_of_testscriptgroup
      end
      it 'create instance' , ci:9 do
        expect(@testscriptgroup).not_to eq(nil)
      end
    end

    context 'Mkscript' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        argv = %W[-d #{o.output_dir} -t #{o.tsv_fname} -c all -s #{o.start_char} -l #{o.limit}]
        @mkscript = conf.create_instance_of_mkscript(argv)
      end
      it 'create instance' , ci:10 do
        expect(@mkscript).not_to eq(nil)
      end
    end
  end

  context 'make script' do
    context 'Mkscript-a' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        argv = %W[-d #{o.output_dir} -t #{o.tsv_fname} -c all -s #{o.start_char} -l #{o.limit}]
        @mkscript = conf.create_instance_of_mkscript(argv)

        @ret = @mkscript.do_process
      end
      it 'create instance' , ms:1 do
        expect(@ret).to eq true
      end
    end

    context 'Mkscript-p' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        argv = %W[-d #{o.output_dir} -t #{o.tsv_fname} -c partial -s #{o.start_char} -l #{o.limit}]
        @mkscript = conf.create_instance_of_mkscript(argv)

        @ret = @mkscript.do_process
      end
      it 'create instance' ,ms:2 do
        expect(@ret).to eq true
      end
    end
  end
end
