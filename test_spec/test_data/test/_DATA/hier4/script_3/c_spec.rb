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

  context "singleton" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("singleton")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = ["-IRUNTIME/tecs-runtime/include"]

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "singleton_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "singleton.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 42 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 43 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "portarray" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("portarray")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = ["-IRUNTIME/tecs-runtime/include"]

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "portarray_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "portarray.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 44 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 45 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "composite_1" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("composite_1")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "composite_1_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "composite.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 46 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 47 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "recursive_composite" do
    before(:each) {
      abs_test_case_parent_dir_pn = target_parent_dir_pn.join(test_case_parent_dir_pn)
      target_dir_pn = abs_test_case_parent_dir_pn.join("recursive_composite")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = ["-IRUNTIME/tecs-runtime/include"]

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "recursive_composite_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "recursive_composite.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 48 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 49 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "recursive_composite_2" do
      before(:each) {
        cmdline = make_cmdline_1("2", "recursive_composite.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 50 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 51 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "recursive_composite_2_idx_is_id" do
      before(:each) {
        cmdline = make_cmdline_1("2_idx_is_id", "recursive_composite.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 52 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 53 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "recursive_composite_3" do
      before(:each) {
        cmdline = make_cmdline_1("3", "recursive_composite.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 54 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 55 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
