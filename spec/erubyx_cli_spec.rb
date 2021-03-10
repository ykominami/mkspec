# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.describe 'command-line', type: :aruba do
  include UtilHelper
  let(:spec_dir_pn){Pathname.new(__FILE__).parent}
  let(:yml_fname){''}
  let(:target_cmd_1){}
  let(:target_cmd_2){}
#  let(:tecsgen_cmd) {'tecsgen'}
  let(:target_cmd_1) {'make_scra'}
  let(:target_cmd_2) {'make_rspec'}
  let(:test_cmd){'cmd.sh'}
  let(:top_pn){ Pathname.new( ENV['TEST_TOP_DIR'] ) }
  let(:test_data_dir_pn){spec_dir_pn + 'test_data' + '_DATA'}
  let(:test_data_dir){test_data_dir_pn.to_s}
  let(:test_case_dir_pn){test_data_dir_pn + 'test_case'}
  let(:test_case_dir){test_case_dir_pn.to_s}
  let(:result){'result.txt'}
  let(:test_1){'test_1'}
  let(:test_2){'test_2'}
  let(:test_data_yaml_fname) {'s4.yml'}
  let(:data_fname) {"testlist.txt"}
  let(:conf){UtilHelper.make_conf(top_pn, test_data_dir, test_case_dir, test_cmd, target_cmd_1, target_cmd_2)}

  context 'make_scra' do
    before(:each) {
      @target_parent_dir_pn = test_case_dir_pn + 'make_scra'
      @parent_test_data_dir_pn = test_data_dir_pn + 'hier'
#      @tsv_file_pn = @parent_test_data_dir_pn + 'testlist.txt'
#      @yaml_file_pn = @parent_test_data_dir_pn + 'f.yml'
      @tsv_file_pn = 'testlist.txt'
      @yaml_file_pn = 's4.yml'
      @tsv_file = 'testlist.txt'
      @yaml_file = 'f.yml'
    }
    def make_cmdline_1(num, *file_list)
      target_dir, result_file_path = conf.make_target_dir_and_result_file_path( @target_parent_dir_pn , num , result)
      option_extra = []
      conf.make_cmdline_1( target_dir , result_file_path, option_extra.join(' '), file_list )
    end

    context 'make_scra-1' do
      before(:each) {
        cmdline = make_cmdline_1(1, ['-d', @parent_test_data_dir_pn , @tsv_file_pn, @yaml_file_pn])
        #pry

        @make_scra = run_command("bash #{cmdline}")
      }
      it '', test_normal_sh:true do expect(last_command_started).to be_successfully_executed end
      it '', test_normal_sh_out:true do expect(last_command_started).not_to have_output(/error:/) end
      it '', test_normal_sh_out:true do expect(last_command_started).to have_output(/error:/) end
    end
  end
end
