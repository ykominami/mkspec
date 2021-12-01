require 'spec_helper'
require 'pathname'

RSpec.describe 'tecsgen command', type: :aruba do
  include TestConf

let(:test_case_parent_dir) { 'test_case' }
let(:test_case_parent_dir_pn) { Pathname.new(test_case_parent_dir) }
let(:conf) { TestConf::TestConf.new( '/home/ykominami/repo/mkspec_data/global.yml', '/home/ykominami/repo/mkspec/bin/mkspec', '', __FILE__) }
let(:o) { conf.o }
let(:original_output_dir_pn) { o.original_output_dir_pn }
let(:original_output_dir) { original_output_dir_pn.to_s }

before(:each) {
  ENV['TECSPATH'] = '/home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecslib'
  ENV['PATH'] = ['/home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecsgen', ENV['PATH']].join(':')
}

  context 'allocator' do
  before(:each) {
    target_dir_pn = test_case_parent_dir_pn.join('allocator')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'allocator_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "allocator.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:90 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:91 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'allocator_2' do
  before(:each) {
    cmdline = make_cmdline_1('2', "allocator.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:92 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:93 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'allocator_CB' do
  before(:each) {
    cmdline = make_cmdline_1('CB', "allocator.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:94 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:95 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'romram' do
  before(:each) {
    target_dir_pn = test_case_parent_dir_pn.join('romram')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'romram_normal' do
  before(:each) {
    cmdline = make_cmdline_1('normal', "romram.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:96 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:97 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'romram_r' do
  before(:each) {
    cmdline = make_cmdline_1('r', "romram.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:98 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:99 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'romram_ram_initializer' do
  before(:each) {
    cmdline = make_cmdline_1('ram_initializer', "romram.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:100 do expect(last_command_started).1 be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:101 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
end
