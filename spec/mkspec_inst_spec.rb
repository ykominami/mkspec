# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  #
  context 'format' do
    before(:each) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @conf = Mkspec::TestConf.new(ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '', __FILE__, nil)
      @o = @conf.o
      str=<<EOS
      class A
def initialize()
end

def m1
end
end
EOS
      @ret = Mkspec::Mkscript.format(str)
      format_pn = @o._test_data_dir_pn + @o.format_fname
      @value = File.read(format_pn)
    end

    it 'format' , f:true do
      expect(@ret).to eq(@value)
    end
  end

  context 'create instance of class' do
    before(:all) do
      @conf = Mkspec::TestConf.new(ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '', __FILE__, nil)
      @o = @conf.o
    end
    context 'Config' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @config = @conf.create_instance_of_config
      end
      it 'create instance' , ci:1 do
        expect(@config).not_to eq(nil)
      end
    end

    context 'Root' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @root = @conf._create_instance_of_root
      end
      it 'create instance' , ci:2 do
        expect(@root).not_to eq(nil)
      end
    end

    context 'Item' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        Mkspec::Util.dump_var(:o_content_fname, @o.content_fname)
        Mkspec::Util.dump_var(:o_yaml_fname, @o.yaml_fname)
        content_path = @o._data_dir_pn.join(@o.content_fname)
        yaml_path = @o._data_dir_pn.join(@o.yaml_fname)
        @item = @conf._create_instance_of_item(content_path, yaml_path)
      end

      it 'create instance' , ci:3 do
        expect(@item).not_to eq(nil)
      end
    end

    context 'Setting' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @setting = @conf._create_instance_of_setting
      end
      it 'create instance' , ci:4 do
        expect(@setting).not_to eq(nil)
      end
    end

    context 'Templatex' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @templatex = @conf._create_instance_of_templatex
      end
      it 'create instance' , ci:5 do
        expect(@templatex).not_to eq(nil)
      end
    end

    context 'TestGroup' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testgroup = @conf.create_instance_of_testgroup_0
      end
      it 'create instance' , ci:6 do
        expect(@testgroup).not_to eq(nil)
      end
    end

    context 'TestCase' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testcase = @conf.create_instance_of_testcase
      end
      it 'create instance' , ci:7 do
        expect(@testcase).not_to eq(nil)
      end
    end

    context 'TestScript' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testscript = @conf.create_instance_of_testscript
      end
      it 'create instance' , ci:8 do
        expect(@testscript).not_to eq(nil)
      end
    end

    context 'TestScriptGroup' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testscriptgroup = @conf.create_instance_of_testscriptgroup
      end
      it 'create instance' , ci:9 do
        expect(@testscriptgroup).not_to eq(nil)
      end
    end

    context 'Mkscript' do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      before(:each) do
        tsv_fname = @o.misc_tsv_fname

  #                       global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path, original_output_dir = nil
        argv = %W[
                -g #{@o[Mkspec::GlobalConfig::GLOBAL_YAML_FNAME_KEY]}
                -o #{@o.output_dir}
                -t #{@o.tsv_fname}
                -c all
                -s #{@o.start_char}
                -l #{@o.limit}
                -x #{@o.original_output_dir}
                -y #{@o.target_cmd_1_pn}
                -z #{@o.target_cmd_2_pn}
              ]
        @mkscript = @conf.create_instance_of_mkscript(argv)
      end
      it 'create instance' , ci:10 do
        expect(@mkscript).not_to eq(nil)
      end
    end

    context 'GlobalConfig' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        specific_yaml = ENV['MKSPEC_SPECIFIC_YAML_FNAME']
        global_yaml = ENV['MKSPEC_GLOBAL_YAML_FNAME']
        target_cmd_1 = "tecsgen"
        target_cmd_2 = "tecsmerge"
        original_spec_file_path = __FILE__
        Mkspec::Util.dump_var(:specific_yaml, specific_yaml )
        top_dir = nil
        @ret = Mkspec::GlobalConfig.new(specific_yaml, global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path, top_dir)
      end

      it 'ret' , xcmd:1 do
  #      expect(@ret.instance_of?(String)).to eq(true)
        expect(@ret.class).to eq(Mkspec::GlobalConfig)
      end
    end
  end
end
