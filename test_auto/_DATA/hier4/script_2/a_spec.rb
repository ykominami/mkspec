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

  context "data_normal" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("data_normal")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "data_normal_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "data_normal.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 0 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 1 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "data_normal_2" do
      before(:each) {
        cmdline = make_cmdline_1("2", "data_normal.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 2 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 3 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "data_flat" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("data_flat")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "data_flat_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "jsp_flat.sig.CPP sample1_flat.blt.CPP sample1_flat.ct.CPP")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 4 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 5 do expect(last_command_started).to have_output(/error:/) end
    end
  end
  context "data_abnormal" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("data_abnormal")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "data_abnormal_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "data_abnormal.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 6 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 7 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_abnormal_2" do
      before(:each) {
        cmdline = make_cmdline_1("2", "data_abnormal.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 8 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 9 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_abnormal_3" do
      before(:each) {
        cmdline = make_cmdline_1("3", "data_abnormal.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 10 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 11 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_abnormal_4" do
      before(:each) {
        cmdline = make_cmdline_1("4", "data_abnormal.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 12 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 13 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_abnormal_5" do
      before(:each) {
        cmdline = make_cmdline_1("5", "data_abnormal.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 14 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 15 do expect(last_command_started).to have_output(/error:/) end
    end
  end
end
