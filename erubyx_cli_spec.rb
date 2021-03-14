# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.describe 'command-line', type: :aruba do
  include UtilHelper

  let(:spec_pn) { Pathname.new(__FILE__).parent }
  let(:spec_dir) { spec_pn.to_s }
  let(:yml_fname) { '' }

  let(:tecsgen) { 'tecsgen' }
  let(:test_cmd) { 'cmd.sh' }
  let(:top_pn) { Pathname.new(ENV['PWD']) }
  let(:test_dir_pn) { "#{spec_pn}test" }
  let(:output_dir) { "#{Pathname.new('_DATA')}hier3".to_s }

  let(:test_misc_dir_pn) { "#{test_dir_pn}misc" }
  let(:test_misc_dir) { test_misc_dir_pn.to_s }
  let(:test_case_dir_pn) { "#{test_dir_pn}test_case" }
  let(:test_case_dir) { test_case_dir_pn.to_s }
  let(:asp_dir) { "#{test_dir_pn}asp+tecs" }
  let(:asp3_dir) { "#{test_dir_pn}asp3" }
  let(:tecsmerge_cmd) { 'tecsmerge' }
  let(:result) { 'result.txt' }
  let(:start_char) { 'a' }
  let(:limit) { 6 }
  let(:test_1) { 'test_1' }
  let(:test_2) { 'test_2' }
  #  let(:yaml_fname) {'s4.yml'}
  let(:tsv_fname) { 'testlist-x.txt' }
  let(:config_0) { Erubyx::Config.new(output_dir) }
  let(:conf) { UtilHelper.make_conf(config_0, test_cmd, tecsgen, tecsmerge_cmd) }

  def misc_tsv_fname
    config_0.make_path_under_misc_dir(tsv_fname)
  end

  context 'make script' do
    before(:each) do
      tsv_fname = misc_tsv_fname
      argv = %W[-d #{output_dir} -t #{tsv_fname} -c all -s #{start_char} -l #{limit}]
    end
    def make_cmdline_1(num, *file_list)
      target_dir, result_file_path = conf.make_target_dir_and_result_file_path(@target_parent_dir_pn, num, result)
      option_extra = []
      conf.make_cmdline_1(target_dir, result_file_path, option_extra.join(' '), file_list)
    end

    context 'make_script-1' do
      before(:each) do
        cmdline = make_cmdline_1(1, ['-d', @parent_test_data_dir_pn, @tsv_file_pn, @yaml_file_pn])
        # pry
        @make_script = run_command("bash #{cmdline}")
      end
      it '', test_normal_sh: true do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out: true do expect(last_command_started).not_to have_output(/error:/) end
      it '', test_normal_sh_out: true do expect(last_command_started).to have_output(/error:/) end
    end
  end

  context 'make_script' do
    before(:each) do
      @target_parent_dir_pn = "#{test_case_dir_pn}make_scra"
      @parent_test_data_dir_pn = "#{test_data_dir_pn}hier"
      @tsv_file_pn = 'testlist.txt'
      @yaml_file_pn = 's4.yml'
      @tsv_file = 'testlist.txt'
      @yaml_file = 'f.yml'
    end
    def make_cmdline_1(num, *file_list)
      target_dir, result_file_path = conf.make_target_dir_and_result_file_path(@target_parent_dir_pn, num, result)
      option_extra = []
      conf.make_cmdline_1(target_dir, result_file_path, option_extra.join(' '), file_list)
    end

    context 'make_scra-1' do
      before(:each) do
        cmdline = make_cmdline_1(1, ['-d', @parent_test_data_dir_pn, @tsv_file_pn, @yaml_file_pn])
        # pry

        @make_scra = run_command("bash #{cmdline}")
      end
      it '', test_normal_sh: true do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out: true do expect(last_command_started).not_to have_output(/error:/) end
      it '', test_normal_sh_out: true do expect(last_command_started).to have_output(/error:/) end
    end
  end
end
