# frozen_string_literal: true

require "spec_helper_1"

logger_init_x

RSpec.describe Mkspec do
  context "format" do
    before(:each) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
    end

    let(:str) do
      <<~END_OF_BLOCK
              class A
        def initialize()
        end

        def m1
        end
        end
      END_OF_BLOCK
    end
    let(:ret) { Mkspec::Mkscript.format(str) }
    let(:format_pn) { @ost._test_data_dir_pn.join(@ost.format_fname) }
    let(:value) { File.read(format_pn) }

    it "@conf", a: 1 do
      expect(@conf).not_to be_nil
    end

    it "format", a: 2 do
      expect(ret).to eq(value)
    end
  end

  context "create instance of class" do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
    end

    context "Config" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:config) { @conf.create_instance_of_config }

      it "create instance", cli: 0 do
        expect(config).not_to be_nil
      end
    end

    context "Root" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:root) { @conf._create_instance_of_root }

      it "create instance", cli: 2 do
        expect(root).not_to be_nil
      end
    end

    context "Item" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        Mkspec::Util.dump_var(:o_content_fname, @ost.content_fname)
        Mkspec::Util.dump_var(:o_yaml_fname, @ost.yaml_fname)
      end

      let(:content_path) { @ost._data_dir_pn.join(@ost.content_fname) }
      let(:yaml_path) { @ost._data_dir_pn.join(@ost.yaml_fname) }
      let(:item) { @conf._create_instance_of_item(content_path, yaml_path) }

      it "create instance", cli: 3 do
        expect(item).not_to be_nil
      end
    end

    context "Setting" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:setting) { @conf._create_instance_of_setting }

      it "create instance", cli: 4 do
        expect(setting).not_to be_nil
      end
    end

    context "Templatex" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        config = @conf.create_instance_of_config
        @templatex = if config.nil?
                       nil
                     else
                       @conf._create_instance_of_templatex(config)
                     end
      end

      it "create instance", cli: 5 do
        expect(@templatex).not_to be_nil
      end
    end

    context "TestGroup" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testgroup) { @conf.create_instance_of_testgroup_0 }

      it "create instance", cli: 6 do
        expect(testgroup).not_to be_nil
      end
    end

    context "TestCase" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testcase) { @conf.create_instance_of_testcase }

      it "create instance", cli: 7 do
        expect(testcase).not_to be_nil
      end
    end

    context "TestScript" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testscript) { @conf.create_instance_of_testscript }

      it "create instance", cli: 8 do
        expect(testscript).not_to be_nil
      end
    end

    context "TestScriptGroup" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testscriptgroup) { @conf.create_instance_of_testscriptgroup }

      it "create instance", cli: 9 do
        expect(testscriptgroup).not_to be_nil
      end
    end

    context "Mkscript" do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      let(:tsv_fname) { @ost.misc_tsv_fname }
      let(:argv) do
        %W[
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
      end
      let(:mkscript) { @conf.create_instance_of_mkscript(argv) }

      it "create instance", cli: 10 do
        expect(mkscript).not_to be_nil
      end
    end

    context "GlobalConfig" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @conf = TestHelp.make_testconf
        @top_dir_yaml, @resolved_top_dir_yaml, @specific_yaml, @global_yaml = Mkspec::Util.adjust_paths
        Mkspec::Util.dump_var(:specific_yaml, @specific_yaml)
        raise unless @top_dir_yaml
        raise unless @resolved_top_dir_yaml
      end

      let(:target_cmd_1) { "tecsgen" }
      let(:target_cmd_2) { "tecsmerge" }
      let(:original_spec_file_path) { __FILE__ }

      let(:top_dir_hash) { Mkspec::Util.make_hash_from_files(@top_dir_yaml, @resolved_top_dir_yaml) }

      it "ret", xcmd: 1 do
        ret = Mkspec::GlobalConfig.new(false, top_dir_hash, @specific_yaml.pathname,
                                       @global_yaml.pathname, target_cmd_1, target_cmd_2, original_spec_file_path)
        expect(ret.class).to eq(Mkspec::GlobalConfig)
      end
    end
  end
end
