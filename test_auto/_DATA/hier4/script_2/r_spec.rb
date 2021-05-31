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

  context "mruby_mrubybridge" do
    before(:each) {
      target_dir_pn = test_case_dir_pn.join("mruby_mrubybridge")
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
      it "execute successfully", test_normal_sh: true, tc: 216 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 217 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_ASP3" do
      before(:each) {
        cmdline = make_cmdline_1("ASP3", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 218 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 219 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_SimpleSample" do
      before(:each) {
        cmdline = make_cmdline_1("SimpleSample", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 220 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 221 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_TECSInfo" do
      before(:each) {
        cmdline = make_cmdline_1("TECSInfo", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 222 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 223 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_TECSInfoCompo" do
      before(:each) {
        cmdline = make_cmdline_1("TECSInfoCompo", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 224 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 225 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_region" do
      before(:each) {
        cmdline = make_cmdline_1("region", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 226 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 227 do expect(last_command_started).not_to have_output(/error:/) end
    end
    context "mruby_mrubybridge_test" do
      before(:each) {
        cmdline = make_cmdline_1("test", "mruby_mrubybridge.cdl")

        run_command("bash #{cmdline}")
      }
      it "execute successfully", test_normal_sh: true, tc: 228 do expect(last_command_started).to be_successfully_executed end
      it "don't have error in output", test_normal_sh_out: true, tc: 229 do expect(last_command_started).not_to have_output(/error:/) end
    end
  end
end
