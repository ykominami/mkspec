require "spec_helper"
require "aruba/rspec"
require "pathname"

RSpec.describe "tecsgen command", type: :aruba do
  let(:test_case_parent_dir) { "test_case" }
  let(:test_case_parent_dir_pn) { Pathname.new(test_case_parent_dir) }
  let(:conf) { Mkspec::TestConf.new(ENV["MKSPEC_SPECIFIC_YAML_FNAME"], ENV["MKSPEC_GLOBAL_YAML_FNAME"], "/home/ykominami/repo/ykominami/mkspec/bin/mkspec", "/home/ykominami/repo/ykominami/mkspec/bin", __FILE__, "/home/ykominami/repo/ykominami/mkspec") }
  let(:o) { conf.o }
  let(:original_output_dir_pn) { o.original_output_dir_pn }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:target_parent_dir_pn) { o.target_parent_dir_pn }
  let(:inc_dir) { o.spec_test_test_include_dir_pn }
  let(:dq) { %s!\"\"! }

  context "mruby_mrubybridge" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("mruby_mrubybridge")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "mruby_mrubybridge_ASP" do
      before(:each) {
        cmdline = make_cmdline_1("ASP", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 218 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 219 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_ASP3" do
      before(:each) {
        cmdline = make_cmdline_1("ASP3", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 220 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 221 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_SimpleSample" do
      before(:each) {
        cmdline = make_cmdline_1("SimpleSample", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 222 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 223 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_TECSInfo" do
      before(:each) {
        cmdline = make_cmdline_1("TECSInfo", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 224 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 225 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_TECSInfoCompo" do
      before(:each) {
        cmdline = make_cmdline_1("TECSInfoCompo", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 226 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 227 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_region" do
      before(:each) {
        cmdline = make_cmdline_1("region", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 228 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 229 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_test" do
      before(:each) {
        cmdline = make_cmdline_1("test", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 230 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 231 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
