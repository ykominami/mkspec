require "spec_helper_3"
require "aruba/rspec"
require "pathname"

RSpec.describe "tecsgen command", type: :aruba do
  let(:test_case_parent_dir) { "test_case" }
  let(:test_case_parent_dir_pn) { Pathname.new(test_case_parent_dir) }
  let(:conf) { Mkspec::TestConf.new(ENV["MKSPEC_TOP_DIR_YAML_FNAME"], ENV["MKSPEC_SPECIFIC_YAML_FNAME"], ENV["MKSPEC_GLOBAL_YAML_FNAME"], "/home/ykominami/repo/mkspec/bin/mkspec", "/home/ykominami/repo/mkspec/bin", __FILE__, "/home/ykominami/repo/mkspec") }
  let(:o) { conf.o }
  let(:original_output_dir_pn) { o.original_output_dir_pn }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:target_parent_dir_pn) { o.target_parent_dir_pn }
  let(:inc_dir) { o.spec_test_test_include_dir_pn }
  let(:dq) { %s!\"\"! }

  context "dynamic" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("dynamic")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "dynamic_normal" do
      before(:each) {
        cmdline = make_cmdline_1("normal", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 184 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 185 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_ram_initializer" do
      before(:each) {
        cmdline = make_cmdline_1("ram_initializer", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 186 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 187 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_ramonly" do
      before(:each) {
        cmdline = make_cmdline_1("ramonly", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 188 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 189 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_singleton" do
      before(:each) {
        cmdline = make_cmdline_1("singleton", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 190 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 191 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_singleton_ramonly" do
      before(:each) {
        cmdline = make_cmdline_1("singleton_ramonly", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 192 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 193 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_singleton_ram_initializer" do
      before(:each) {
        cmdline = make_cmdline_1("singleton_ram_initializer", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 194 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 195 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_array" do
      before(:each) {
        cmdline = make_cmdline_1("array", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 196 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 197 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_array_r" do
      before(:each) {
        cmdline = make_cmdline_1("array_r", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 198 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 199 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_array_ram_initializer" do
      before(:each) {
        cmdline = make_cmdline_1("array_ram_initializer", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 200 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 201 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_singleton_array" do
      before(:each) {
        cmdline = make_cmdline_1("singleton_array", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 202 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 203 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_singleton_array_r" do
      before(:each) {
        cmdline = make_cmdline_1("singleton_array_r", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 204 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 205 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "dynamic_singleton_array_ram_initializer" do
      before(:each) {
        cmdline = make_cmdline_1("singleton_array_ram_initializer", "dynamic.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 206 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 207 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
