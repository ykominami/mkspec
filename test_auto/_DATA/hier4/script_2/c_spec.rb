# frozen_string_literal: true
require "spec_helper"
require "pathname"

RSpec.describe "tecsgen command", type: :aruba do
  include TestConf

  let(:original_output_dir) { "_DATA/hier4" }
  let(:abs_test_case_dir) { "/home/ykominami/repo/mkspec/test_auto/_DATA/hier4/test_case" }
  let(:test_case_dir_pn) { Pathname.new(abs_test_case_dir) }
  let(:conf) { TestConf::TestConf.new("/home/ykominami/repo/mkspec_data/global.yml", "/home/ykominami/repo/mkspec/bin/mkspec", "", __FILE__) }
  let(:o) { conf.o }

  before(:each) {
    ENV["TECSPATH"] = "/home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecslib"
    ENV["PATH"] = ["/home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecsgen", ENV["PATH"]].join(":")
  }

  context "singleton" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("singleton")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

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
  context "poartarray" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("poartarray")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "poartarray_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "poartarray.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 44 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 45 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "cmoposite_1" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("cmoposite_1")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "cmoposite_1_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "cmoposite_1.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 46 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 47 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "recursive_composite" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("recursive_composite")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

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
