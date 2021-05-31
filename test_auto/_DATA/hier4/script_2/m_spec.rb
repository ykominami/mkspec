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

  context "sharedOpaqueRPC" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("sharedOpaqueRPC")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "sharedOpaqueRPC_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "sharedOpaqueRPC.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 158 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 159 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "signaturePlugin" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("signaturePlugin")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "signaturePlugin_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "signaturePlugin.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 160 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 161 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "celltypePlugin" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("celltypePlugin")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "celltypePlugin_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "celltypePlugin.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 162 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 163 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "cellPlugin" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("cellPlugin")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "cellPlugin_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "cellPlugin.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 164 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 165 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "cppbridge" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("cppbridge")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "cppbridge_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "cppbridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 166 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 167 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "reverse_require" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("reverse_require")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "reverse_require_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "reverse_require.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 168 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 169 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
