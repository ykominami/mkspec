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

  context "id" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("id")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "id_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "id.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 68 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 69 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "attribute" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("attribute")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "attribute_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "attribute.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 70 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 71 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "attribute_2" do
      before(:each) {
        cmdline = make_cmdline_1("2", "attribute.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 72 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 73 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "attribute_3" do
      before(:each) {
        cmdline = make_cmdline_1("3", "attribute.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 74 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 75 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "bool" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("bool")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "bool_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "bool.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 76 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 77 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "var" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("var")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "var_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "var.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 78 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 79 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
