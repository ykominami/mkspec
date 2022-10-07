# frozen_string_literal: true

# require 'spec_helper'
require 'spec_helper_2'
require 'pry'
require 'aruba/rspec'

RSpec.describe 'command-line', type: :aruba do
  #include TestConf

  before(:all) {
    Mkspec::Loggerxcm.fatal("#### mkspec_cli_spec.rb ####")
    @conf = TestHelp.make_testconf
    @ost = @conf.ost
  }

  context 'make script' do
    before(:each) do
      tsv_fname = @ost.misc_tsv_fname
    end

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @ost.cmdline_0.make_cmdline_1(test_case_dir, @ost.result, option_extra.join(' '), file_list)
    end

    # test_auto/_DATA/hier5
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      /template_and_data(出力先)
    #                      /script(出力先)
    context 'create all files' do
      before(:each) do
        test_case_dir = 1
        argv = %W[-D #{@ost.top_dir_yaml_fname} -G #{@ost.specific_yaml_fname}
                  -g #{@ost.global_yaml_fname} -o #{@ost.output_dir} -t #{@ost.tsv_fname} -c all -s #{@ost.start_char}
                  -l #{@ost.limit} -x #{@ost.original_output_dir}
                  -y #{@ost.target_cmd_1_pn} -z #{@ost.target_cmd_2_pn}
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, cmd: 0, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, cmd: 1, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
  #      it '', test_normal_sh_out_error:true do expect(last_command_started).to have_output(/error:/) end
    end

    # test_auto/_DATA/hier5
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      #/template_and_data(出力先)
    #                      /template_and_data_2(今回の出力先)　ここに出力するだけ
    #                      /script(出力先)
    context 'create files under template_and_data_2 directory' do
      before(:each) do
        test_case_dir = 1
        tsv_fname = @ost.misc_tsv_fname
        argv = %W[-D #{@ost.top_dir_yaml_fname} -G #{@ost.specific_yaml_fname}
                  -g #{@ost.global_yaml_fname} -o #{@ost.output_dir}
                  -i #{@ost.tad_2_dir} -t #{@ost.tsv_fname} -c tad -s #{@ost.start_char}
                  -l #{@ost.limit} -x #{@ost.original_output_dir}
                  -y #{@ost.target_cmd_1_pn} -z #{@ost.target_cmd_2_pn}
                  -L #{@ost.log_dir}]

        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, cmd: 2, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, cmd: 3, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
  #      it '', test_normal_sh_out_error:true do expect(last_command_started).to have_output(/error:/) end
    end

    # test_auto/_DATA/hier9
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      #/template_and_data(出力先)
    #                      /template_and_data_2(今回の参照先)　ここは参照するだけ
    #                      #/script(出力先)
    #                      /script_3 (今回の出力先)　ここに出力するだけ
    context 'create spec files from files under templaet_and_data_2 to script_3 directory' do
      before(:each) do
        test_case_dir = 1
        tsv_fname = @ost.misc_tsv_fname
        argv = %W[-D #{@ost.top_dir_yaml_fname}
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
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, cmd: 4, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, cmd: 5, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context 'create all files to script x from tadx' do
      before(:each) do
        test_case_dir = 1
        argv = %W[-D #{@ost.top_dir_yaml_fname}
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
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, xcmd: 6, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, cmd: 7, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context 'create all files to script y from tady' do
      before(:each) do
        test_case_dir = 1
        argv = %W[-D #{@ost.top_dir_yaml_fname}
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
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, xcmd: 1, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, xcmd: 2, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context 'create all files to script y only from tady' do
      before(:each) do
        test_case_dir = 1
        argv = %W[-D #{@ost.top_dir_yaml_fname}
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
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, xcmd: 3, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, xcmd: 4, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context 'create all files to script x from tadv' do
      before(:each) do
        test_case_dir = 1
        argv = %W[-D #{@ost.top_dir_yaml_fname}
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
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, ycmd: 0, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, ycmd: 1, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
    end

    context 'create all files to script y from tadw' do
      before(:each) do
        test_case_dir = 1
        argv = %W[-D #{@ost.top_dir_yaml_fname}
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
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, ycmd: 2, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, ycmd: 3, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
  #      it '', test_normal_sh_out_error:true do expect(last_command_started).to have_output(/error:/) end
    end

    context 'create all files to script y only from tadw' do
      before(:each) do
        test_case_dir = 1
        argv = %W[-D #{@ost.top_dir_yaml_fname}
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
                  -L #{@ost.log_dir}]
        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it 'execute successfully', test_normal_sh: true, ycmd: 4, cli: true do
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', test_normal_sh_out: true, ycmd: 5, cli: true do
        expect(last_command_started).not_to have_output(/error:/)
      end
    end
  end
end
