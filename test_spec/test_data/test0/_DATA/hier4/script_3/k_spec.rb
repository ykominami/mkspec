require "spec_helper"
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

  context "merge" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("merge")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "merge_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "merge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 134 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 135 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "merge_2" do
      before(:each) {
        cmdline = make_cmdline_1("2", "merge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 136 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 137 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "merge_3" do
      before(:each) {
        cmdline = make_cmdline_1("3", "merge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 138 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 139 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "merge_4" do
      before(:each) {
        cmdline = make_cmdline_1("4", "merge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 140 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 141 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "merge_5" do
      before(:each) {
        cmdline = make_cmdline_1("5", "merge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 142 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 143 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "merge_6" do
      before(:each) {
        cmdline = make_cmdline_1("6", "merge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 144 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 145 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "merge_6_2" do
      before(:each) {
        cmdline = make_cmdline_1("6_2", "merge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 146 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 147 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
