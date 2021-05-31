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

  context "hello" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("hello")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "hello_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "hello.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 114 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 115 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "simple" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("simple")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "simple_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "simple.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 116 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 117 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "optional" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("optional")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "optional_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "optional.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 118 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 119 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "series" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("series")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "series_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "series.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 120 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 121 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "pointer" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("pointer")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "pointer_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "pointer.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 122 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 123 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "c_exp" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("c_exp")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "c_exp_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "c_exp.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 124 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 125 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
