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

  context "data_error" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("data_error")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "data_error_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 16 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 17 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_2" do
      before(:each) {
        cmdline = make_cmdline_1("2", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 18 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 19 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_3" do
      before(:each) {
        cmdline = make_cmdline_1("3", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 20 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 21 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_4" do
      before(:each) {
        cmdline = make_cmdline_1("4", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 22 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 23 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_5" do
      before(:each) {
        cmdline = make_cmdline_1("5", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 24 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 25 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_6" do
      before(:each) {
        cmdline = make_cmdline_1("6", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 26 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 27 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_7" do
      before(:each) {
        cmdline = make_cmdline_1("7", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 28 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 29 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_8" do
      before(:each) {
        cmdline = make_cmdline_1("8", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 30 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 31 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_9" do
      before(:each) {
        cmdline = make_cmdline_1("9", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 32 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 33 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_10" do
      before(:each) {
        cmdline = make_cmdline_1("10", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 34 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 35 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_11" do
      before(:each) {
        cmdline = make_cmdline_1("11", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 36 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 37 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_12" do
      before(:each) {
        cmdline = make_cmdline_1("12", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 38 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 39 do expect(last_command_started).to have_output(/error:/) end
    end
    context "data_error_13" do
      before(:each) {
        cmdline = make_cmdline_1("13", "data_error.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 40 do expect(last_command_started).not_to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 41 do expect(last_command_started).to have_output(/error:/) end
    end
  end
end
