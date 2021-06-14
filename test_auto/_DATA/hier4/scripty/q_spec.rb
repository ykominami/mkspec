
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

  context 'tecsInfo' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('tecsInfo')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'tecsInfo_raminitializer' do
  before(:each) {
    cmdline = make_cmdline_1('raminitializer', "tecsInfo.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:208 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:209 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'tecsinfo' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('tecsinfo')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'tecsinfo_ramonly' do
  before(:each) {
    cmdline = make_cmdline_1('ramonly', "tecsinfo.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:210 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:211 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'tecsinfoaccessor' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('tecsinfoaccessor')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'tecsinfoaccessor_raminitializer' do
  before(:each) {
    cmdline = make_cmdline_1('raminitializer', "tecsinfoaccessor.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:212 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:213 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'tecsinfoaccessor_ramonly' do
  before(:each) {
    cmdline = make_cmdline_1('ramonly', "tecsinfoaccessor.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:214 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:215 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
end