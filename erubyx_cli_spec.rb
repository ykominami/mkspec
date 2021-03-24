# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.describe 'command-line', type: :aruba do
  include UtilHelper
  include TestConf

  let(:original_output_dir_pn) { Pathname.new('_DATA').join('hier5') }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:conf) { TestConf::TestConf.new( 'make_script', '', __FILE__, original_output_dir) }
  let(:o) { conf.o }

  context 'make script' do
    before(:each) do
      tsv_fname = o.misc_tsv_fname
    end

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      o.cmdline_0.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
    end

    # test_auto/_DATA/hier5
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      /template_and_data(出力先)
    #                      /script(出力先)
    context 'create all files' do
      before(:each) do
        test_case_dir = 1
        tsv_fname = o.misc_tsv_fname
        argv = %W[-o #{o.output_dir} -t #{o.tsv_fname} -c all -s #{o.start_char} -l #{o.limit}]
        cmdline = make_cmdline_1(test_case_dir, argv)

        run_command("bash #{cmdline}")
      end
      it '', test_normal_sh:true, cmd:0 do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out:true, cmd:1 do expect(last_command_started).not_to have_output(/error:/) end
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
        tsv_fname = o.misc_tsv_fname
        argv = %W[-o #{o.output_dir} -i #{o.tad_2_dir} -t #{o.tsv_fname} -c tad -s #{o.start_char} -l #{o.limit}]
        cmdline = make_cmdline_1(test_case_dir, argv)

        run_command("bash #{cmdline}")
      end
      it '', test_normal_sh:true, cmd:2 do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out:true, cmd:3 do expect(last_command_started).not_to have_output(/error:/) end
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
        tsv_fname = o.misc_tsv_fname
        argv = %W[-o #{o.output_dir} -i #{o.tad_2_dir} -d #{o.script_3_dir} -t #{o.tsv_fname} -c spec -s #{o.start_char} -l #{o.limit}]
        cmdline = make_cmdline_1(test_case_dir, argv)

        run_command("bash #{cmdline}")
      end
      it '', test_normal_sh:true, cmd:4 do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out:true, cmd:5 do expect(last_command_started).not_to have_output(/error:/) end
      # it '', test_normal_sh_out_error:true do expect(last_command_started).to have_output(/error:/) end
    end
  end
end