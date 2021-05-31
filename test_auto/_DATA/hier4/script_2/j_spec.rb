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

  context "const" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("const")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "const_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "const.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 126 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 127 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "float" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("float")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "float_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "float.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 128 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 129 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
  context "sjis" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("sjis")
      @cmdline = Clitest::Cmdline.new(nil, nil, target_dir_pn, "tecsgen")
    }

    def make_cmdline_1(test_case_dir, *file_list)
      option_extra = []

      @cmdline.make_cmdline_1(test_case_dir, o.result, option_extra.join(" "), file_list)
    end

    context "sjis_1" do
      before(:each) {
        cmdline = make_cmdline_1("1", "sjis.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 130 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 131 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
