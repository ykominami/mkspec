# frozen_string_literal: true

require "spec_helper_1"

logger_init_x

RSpec.describe Mkspec do
  context "with format" do
    before(:all) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @conf = TestHelp.make_testconf
      # puts "@conf=#{@conf}"
      @ost = @conf.ost
      #  puts "@ost=#{@ost}"
      # puts "@ost.format_fname=#{@ost.format_fname}|"
      @format_fname = @ost.format_fname
      # puts "@format_fname=#{@format_fname}|"
      # puts "@ost.test_root_dir_pn=#{@ost.test_root_dir_pn }"
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
    #    let(:format_fname) { @ost.format_fname }

    let(:format_pn) { @ost._test_data_dir_pn.join(@format_fname) }
    let(:value) { File.read(format_pn) }

    it "@conf", a: 1 do
      expect(@conf).not_to be_nil
    end

    it "format", a: 2 do
      expect(ret).to eq(value)
    end
  end

  context "with create instance of class" do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      # puts "create instance of class | @ost=#{@ost}"
    end

    context "when Config" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:config) { @conf.create_instance_of_config }

      it "create instance", cli: 0 do
        expect(config).not_to be_nil
      end
    end

    context "when Root" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        # puts "Root @conf=#{@conf}"
        # puts "Root @conf.ost=#{@conf.ost}"
        # puts "Root @conf.ost.data_top_dir=#{@conf.ost.data_top_dir}"
      end

      let(:root) { @conf._create_instance_of_root }

      it "create instance", cli: 2 do
        expect(root).not_to be_nil
      end
    end

    context "when Item" do
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

    context "when Setting" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:setting) { @conf._create_instance_of_setting }

      it "create instance", cli: 4 do
        expect(setting).not_to be_nil
      end
    end

    context "when Templatex" do
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

    context "when TestGroup" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testgroup) { @conf.create_instance_of_testgroup_0 }

      it "create instance", cli: 6 do
        expect(testgroup).not_to be_nil
      end
    end

    context "when TestCase" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testcase) { @conf.create_instance_of_testcase }

      it "create instance", cli: 7 do
        expect(testcase).not_to be_nil
      end
    end

    context "when TestScript" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testscript) { @conf.create_instance_of_testscript }

      it "create instance", cli: 8 do
        expect(testscript).not_to be_nil
      end
    end

    context "when TestScriptGroup" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:testscriptgroup) { @conf.create_instance_of_testscriptgroup }

      it "create instance", cli: 9 do
        expect(testscriptgroup).not_to be_nil
      end
    end

    context "when Mkscript" do
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

    context "when GlobalConfig" do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @conf = TestHelp.make_testconf
        # @top_dir_yaml, @resolved_top_dir_yaml, @specific_yaml, @global_yaml = Mkspec::Util.adjust_paths
        @dirs_and_files = Mkspec::Util.adjust_dirs_and_files
        @top_dir_yaml = @dirs_and_files.top_dir_yaml
        @resolved_top_dir_yaml = @dirs_and_files.resolved_top_dir_yaml
        @specific_yaml = @dirs_and_files.specific_yaml
        @global_yaml = @dirs_and_files.global_yaml
        Mkspec::Util.dump_var(:specific_yaml, @specific_yaml)
        raise unless @top_dir_yaml
        raise unless @resolved_top_dir_yaml
      end

      let(:target_cmd_first) { "tecsgen" }
      let(:target_cmd_second) { "tecsmerge" }

      let(:top_dir_hash) { Mkspec::Util.make_hash_from_files(@top_dir_yaml, @resolved_top_dir_yaml) }

      it "ret", xcmd: 1 do
        ret = Mkspec::GlobalConfig.new(false, top_dir_hash, @dirs_and_files, target_cmd_first, target_cmd_second)
        expect(ret.class).to eq(Mkspec::GlobalConfig)
      end
    end
  end
end
