# frozen_string_literal: true

require 'spec_helper_2'
begin
  require 'debug'
recue StandartError => exc
  puts exc.message
end
require 'aruba/rspec'

logger_init_x

RSpec.describe 'command-line', type: :aruba do
  before(:all) do
    Mkspec::Loggerxcm.fatal("#### mkspec_cli_spec.rb ####")
    @conf = TestHelp.make_testconf
    @ost = @conf.ost
  end

  def make_cmdline_1(test_case_dir, file_list)
    option_extra = []

    @ost.cmdline_0.make_cmdline_1(test_case_dir, @ost.result, option_extra.join(' '), file_list)
  end

  context 'with make script' do
    let(:ost) { @ost }
    let(:argv) do
      %W[-D #{ost.top_dir_yaml_fname}
         -r #{ost.resolved_top_dir_yaml_fname}
         -G #{ost.specific_yaml_fname}
         -g #{ost.global_yaml_fname}
         -o #{ost.output_dir}
         -i #{ost.tad_2_dir}
         -t #{ost.tsv_fname}
         -c tad
         -s #{ost.start_char}
         -l #{ost.limit}
         -x #{ost.original_output_dir}
         -y #{ost.target_cmd_1_pn}
         -z #{ost.target_cmd_2_pn}
         -L #{ost.log_dir}]
    end

    # test_auto/_DATA/hier5
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      #/template_and_data(出力先)
    #                      /template_and_data_2(今回の出力先)　ここに出力するだけ
    #                      /script(出力先)
    context 'when create files under template_and_data_2 directory' do
      it 'do successfullyn', :cli, :test_normal_sh_out, cmd: 2 do
        argvx = argv
        test_case_dir = 1
        cmdline = make_cmdline_1(test_case_dir, argvx)
        run_command("clitest #{cmdline}")

        stop_all_commands
        expect(last_command_started).to be_successfully_executed
      end

      it 'do not output error string', :cli, :test_normal_sh_out, cmd: 3 do
        argvx = argv
        test_case_dir = 1
        cmdline = make_cmdline_1(test_case_dir, argvx)
        run_command("clitest #{cmdline}")

        stop_all_commands
        expect(last_command_started).not_to have_output(/error:/)
      end
    end
  end
end
