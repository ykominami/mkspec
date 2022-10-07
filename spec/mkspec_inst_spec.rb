# frozen_string_literal: true

require 'spec_helper_1'

logger_init( "spec/logs" )

RSpec.describe Mkspec do
  context 'format' do
    before(:each) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      str = <<~END_OF_BLOCK
              class A
        def initialize()
        end

        def m1
        end
        end
      END_OF_BLOCK
      @ret = Mkspec::Mkscript.format(str)
      format_pn = @ost._test_data_dir_pn.join(@ost.format_fname)
      @value = File.read(format_pn)
      # puts "@value=#{@value}"
      # puts "@ret=#{@ret}"
    end

    it 'format' , f: true do
      expect(@ret).to eq(@value)
    end
  end

  context 'create instance of class' do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      # raise unless @ost.spec_dir
      raise unless @ost.data_top_dir
      raise unless @ost.output_data_top_dir
      raise unless @ost.output_dir
    end
    context 'Config' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @config = @conf.create_instance_of_config
      end
      it 'create instance' , cli: 1 do
        expect(@config).not_to be_nil
      end
    end

    context 'Root' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @root = @conf._create_instance_of_root
      end
      it 'create instance' , cli: 2 do
        expect(@root).not_to be_nil
      end
    end

    context 'Item' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        Mkspec::Util.dump_var(:o_content_fname, @ost.content_fname)
        Mkspec::Util.dump_var(:o_yaml_fname, @ost.yaml_fname)
        content_path = @ost._data_dir_pn.join(@ost.content_fname)
        yaml_path = @ost._data_dir_pn.join(@ost.yaml_fname)
        @item = @conf._create_instance_of_item(content_path, yaml_path)
      end

      it 'create instance' , cli: 3 do
        expect(@item).not_to be_nil
      end
    end

    context 'Setting' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @setting = @conf._create_instance_of_setting
      end
      it 'create instance' , cli: 4 do
        expect(@setting).not_to be_nil
      end
    end

    context 'Templatex' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        config = @conf.create_instance_of_config
        @templatex = @conf._create_instance_of_templatex(config)
      end
      it 'create instance' , cli: 5 do
        expect(@templatex).not_to be_nil
      end
    end

    context 'TestGroup' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testgroup = @conf.create_instance_of_testgroup_0
      end
      it 'create instance' , cli: 6 do
        expect(@testgroup).not_to be_nil
      end
    end

    context 'TestCase' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testcase = @conf.create_instance_of_testcase
      end
      it 'create instance' , cli: 7 do
        expect(@testcase).not_to be_nil
      end
    end

    context 'TestScript' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testscript = @conf.create_instance_of_testscript
      end
      it 'create instance' , cli: 8 do
        expect(@testscript).not_to be_nil
      end
    end

    context 'TestScriptGroup' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @testscriptgroup = @conf.create_instance_of_testscriptgroup
      end
      it 'create instance' , cli: 9 do
        expect(@testscriptgroup).not_to be_nil
      end
    end

    context 'Mkscript' do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      before(:each) do
        tsv_fname = @ost.misc_tsv_fname

  #                       global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path, original_output_dir = nil
        argv = %W[
          -g #{@ost[Mkspec::GlobalConfig::GLOBAL_YAML_FNAME_KEY]}
          -o #{@ost.output_dir}
          -t #{@ost.tsv_fname}
          -c all
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
        ]
        @mkscript = @conf.create_instance_of_mkscript(argv)
      end
      it 'create instance' , cli: 10 do
        expect(@mkscript).not_to be_nil
      end
    end

    context 'GlobalConfig' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @conf = TestHelp.make_testconf
        top_dir_yaml, specific_yaml, global_yaml = TestHelp.adjust_paths
        target_cmd_1 = "tecsgen"
        target_cmd_2 = "tecsmerge"
        original_spec_file_path = __FILE__
        Mkspec::Util.dump_var(:specific_yaml, specific_yaml )
        top_dir = nil
        @ret = Mkspec::GlobalConfig.new(top_dir_yaml, specific_yaml, global_yaml, target_cmd_1, target_cmd_2,
                                        original_spec_file_path)
      end

      it 'ret' , xcmd: 1 do
        expect(@ret.class).to eq(Mkspec::GlobalConfig)
      end
    end
  end
end
