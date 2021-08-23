# frozen_string_literal: true

# require 'spec_helper'
require 'spec_helper_2'
require 'pry'
require 'aruba/rspec'

RSpec.describe 'command-line', type: :aruba do
  #include TestConf

  before(:all) {
#    Mkspec::Loggerxcm.init("mk_", :default, ENV['MKSPEC_LOG_DIR'], false, :debug)
    Mkspec::Loggerxcm.fatal("#### mkspec_cli_spec.rb ####")
    @top_dir = Pathname.new(__FILE__).parent.to_s
#    @top_dir = nil
    @conf = Mkspec::TestConf.new(ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '', nil, @top_dir)
    @o = @conf.o
  }

  context 'make script' do
    before(:each) do
      tsv_fname = @o.misc_tsv_fname
    end

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @o.cmdline_0.make_cmdline_1(test_case_dir, @o.result, option_extra.join(' '), file_list)
    end

    # test_auto/_DATA/hier5
    #                      /test_case(生成したspecファイルを実行するときに参照)
    #                      #/template_and_data(出力先)
    #                      /template_and_data_2(今回の出力先)　ここに出力するだけ
    #                      /script(出力先)
    context 'create files under template_and_data_2 directory' do
      before(:each) do
        test_case_dir = 1
        tsv_fname = @o.misc_tsv_fname
        argv = %W[ -G #{@o.specific_yaml_fname} -g #{@o.global_yaml_fname} -o #{@o.output_dir} -i #{@o.tad_2_dir} -t #{@o.tsv_fname} -c tad -s #{@o.start_char}
               -l #{@o.limit} -x #{@o.original_output_dir} -y #{@o.target_cmd_1_pn} -z #{@o.target_cmd_2_pn} -T #{@o.top_dir}
               ]

        cmdline = make_cmdline_1(test_case_dir, argv)
        run_command("bash #{cmdline}")
      end
      it '', test_normal_sh:true, cmd:2 do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out:true, cmd:3 do expect(last_command_started).not_to have_output(/error:/) end
  #      it '', test_normal_sh_out_error:true do expect(last_command_started).to have_output(/error:/) end
    end
  end
end
