# frozen_string_literal: true

# require 'spec_helper'
require "bundler/setup"

require "spec_helper_2"
begin
  require "debug"
rescue StandartError => exc
  puts exc.message
end

require "aruba/rspec"

logger_init_x

RSpec.describe "command-line", type: :aruba do
  before(:all) do
    Mkspec::Loggerxcm.fatal("#### mkspec_cli_spec.rb ####")
    @conf = TestHelp.make_testconf
    @ost = @conf.ost
  end

  def make_cmdline_1(test_case_dir, *file_list)
    option_extra = []
    @ost.cmdline_0.make_cmdline_1(test_case_dir, @ost.result, option_extra.join(" "), file_list)
  end

  context "with make script" do
    # test_auto/_DATA/hier5
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      /template_and_data(出力先)
    #                      /script(出力先)
    context "when create all files" do
      let(:ost) { @conf.ost }
      let(:tsv_fname) { ost.misc_tsv_fname }
      let(:argv) do
        %W[
          -G #{ost.specific_yaml_fname}
          -g #{ost.global_yaml_fname}
          -o #{ost.output_dir}
          -t #{ost.tsv_fname}
          -c all
          -s #{ost.start_char}
          -l #{ost.limit}
          -x #{ost.original_output_dir}
          -y #{ost.target_cmd_1_pn}
          -z #{ost.target_cmd_2_pn}
          -L #{ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, cmd: 0 do
        test_case_dir = 1
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, cmd: 1 do
        test_case_dir = 1
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    # test_auto/_DATA/hier5
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      #/template_and_data(出力先)
    #                      /template_and_data_2(今回の出力先)　ここに出力するだけ
    #                      /script(出力先)
    context "when create files under template_and_data_2 directory" do
      test_case_dir = 1
      let(:tsv_fname) { @ost.misc_tsv_fname }
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i #{@ost.tad_2_dir}
          -t #{@ost.tsv_fname}
          -c tad
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, cmd: 2 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, cmd: 3 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    # test_auto/_DATA/hier9
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      #/template_and_data(出力先)
    #                      /template_and_data_2(今回の参照先)　ここは参照するだけ
    #                      #/script(出力先)
    #                      /script_3 (今回の出力先)　ここに出力するだけ
    context "when create spec files from files under templaet_and_data_2 to script_3 directory" do
      test_case_dir = 1
      let(:tsv_fname) { @ost.misc_tsv_fname }
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i #{@ost.tad_2_dir}
          -d #{@ost.script_3_dir}
          -t #{@ost.tsv_fname}
          -c spec
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, cmd: 4 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, cmd: 5 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context "when create all files to script x from tadx" do
      test_case_dir = 1
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i tadx
          -d scriptx
          -t #{@ost.tsv_fname}
          -c all
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, xcmd: 6 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, cmd: 7 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context "when create all files to script y from tady" do
      test_case_dir = 1
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i tady
          -d scripty
          -t #{@ost.tsv_fname}
          -c all
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, xcmd: 1 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, xcmd: 2 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context "when create all files to script y only from tady" do
      test_case_dir = 1
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i tady
          -d scripty
          -t #{@ost.tsv_fname}
          -c spec
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, xcmd: 3 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, xcmd: 4 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context "when create all files to script x from tadv" do
      test_case_dir = 1
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i tadv
          -d scriptv
          -t #{@ost.tsv_fname}
          -c all
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, ycmd: 0 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, ycmd: 1 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context "when create all files to script y from tadw" do
      test_case_dir = 1
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i tadw
          -d scriptw
          -t #{@ost.tsv_fname}
          -c all
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, ycmd: 2 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, ycmd: 3 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context "when create all files to script y only from tadw" do
      test_case_dir = 1
      let(:argv) do
        %W[
          -G #{@ost.specific_yaml_fname}
          -g #{@ost.global_yaml_fname}
          -o #{@ost.output_dir}
          -i tadw
          -d scriptw
          -t #{@ost.tsv_fname}
          -c spec
          -s #{@ost.start_char}
          -l #{@ost.limit}
          -x #{@ost.original_output_dir}
          -y #{@ost.target_cmd_1_pn}
          -z #{@ost.target_cmd_2_pn}
          -L #{@ost.log_dir}
        ]
      end

      it "execute successfully", :cli, :test_normal_sh, ycmd: 4 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        Mkspec::Loggerxcm.debug("cmdline=#{cmdline}")
        run_command("clitest #{cmdline}")
        expect(last_command_started).to be_successfully_executed
      end

      it "do not output error string", :cli, :test_normal_sh_out, ycmd: 5 do
        cmdline = make_cmdline_1(test_case_dir, argv)
        Mkspec::Loggerxcm.debug("cmdline=#{cmdline}")
        run_command("clitest #{cmdline}")
        expect(last_command_started).not_to have_output(/error:/)
      end
    end
  end
end
