
require 'spec_helper_3'
require 'aruba/rspec'
require 'pathname'

RSpec.describe 'tecsgen command', type: :aruba do
  include TestConf

let(:test_case_parent_dir) { 'test_case' }
let(:test_case_parent_dir_pn) { Pathname.new(test_case_parent_dir) }
let(:conf) { TestConf::TestConf.new( ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], '/home/ykominami/repo/mkspec/bin/mkspec', '/home/ykominami/repo/mkspec/bin', __FILE__ , '/home/ykominami/repo/mkspec')}
let(:o) { conf.o }
let(:original_output_dir_pn) { o.original_output_dir_pn }
let(:original_output_dir) { original_output_dir_pn.to_s }
let(:target_parent_dir_pn) { o.target_parent_dir_pn }

before(:each) {
  ENV['TECSPATH'] = '/home/ykominami/repo/ns4-tecsgen/tecsgen/tecsgen/tecslib'
}

  context 'dataqueue' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('dataqueue')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'dataqueue_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "dataqueue.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:146 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:147 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'through' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('through')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'through_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "through.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:148 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:149 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'rpc' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('rpc')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'rpc_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "rpc.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:150 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:151 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'sharedRPC' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('sharedRPC')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'sharedRPC_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "sharedRPC.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:152 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:153 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'opaqueRPC' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('opaqueRPC')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'opaqueRPC_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "opaqueRPC.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:154 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:155 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'opaqueMarshaler' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('opaqueMarshaler')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'opaqueMarshaler_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "opaqueMarshaler.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:156 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:157 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
end