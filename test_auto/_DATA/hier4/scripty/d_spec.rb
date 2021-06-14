
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

  context 'factory' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('factory')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'factory_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "factory.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:56 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:57 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'import_C' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('import_C')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'import_C_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "import_C.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:58 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:59 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'import_C_2' do
  before(:each) {
    cmdline = make_cmdline_1('2', "import_C.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:60 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:61 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'import_C_3' do
  before(:each) {
    cmdline = make_cmdline_1('3', "import_C.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:62 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:63 do expect(last_command_started).not_to have_output(/error:/) end
end
    context 'import_C_4' do
  before(:each) {
    cmdline = make_cmdline_1('4', "import_C.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:64 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:65 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
  context 'init' do
  before(:each) {
    abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
    target_dir_pn = abs_test_case_parent_dir_pn.join('init')
    @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, 'tecsgen')
  }
    def make_cmdline_1(test_case_dir, *file_list)
  option_extra = []

  @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(' '), file_list)
end
    context 'init_1' do
  before(:each) {
    cmdline = make_cmdline_1('1', "init.cdl")

    run_command("bash #{cmdline}")
  }
  it 'execute successfully', test_normal_sh:true , tc:66 do expect(last_command_started).to be_successfully_executed end
  it "don't have error in output", test_normal_sh_out:true , tc:67 do expect(last_command_started).not_to have_output(/error:/) end
end
  end
end