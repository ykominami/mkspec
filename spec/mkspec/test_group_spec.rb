# frozen_string_literal: true

require 'spec_helper_1'

# log_dir = ENV.fetch('MKSPEC_LOG_DIR', "./test_data/logs")
# logger_init(log_dir, level: :debug, stdout_flag: true) #1
logger_init_x

RSpec.describe Mkspec::TestGroup do
  context 'with call methods of TestGroup class' do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      @original_output_dir_pn = @ost.original_output_dir_pn
      @original_output_dir = @ost.original_output_dir
      @test_case_args = Mkspec::Util.make_arg_of_add_test_case_of_testgroup
    end

    context 'when when STATE is SUCCESS' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @conf2 = @conf
        @tg_0 = @conf.create_instance_of_testgroup_0
        @tg_0_name_normalize = @ost.tgroup_0_name_normalize
      end

      it 'call to_s', xcmd: 1 do
        ret = @tg_0.to_s
        expect(ret).to eq(@tg_0_name_normalize)
      end

      context 'when TestGroup_0 add TestCase' do
        before(:all) do
          @conf.add_testcases(@tg_0, 1)
        end

        it 'call add_test_case_1', xcmd: 2 do
          expect(@tg_0.size).to eq(1)
        end

        it 'Size of TestCases of TestGroup_0 equals 1' do
          expect(@tg_0.test_cases.size).to eq(1)
        end

        it 'Tail of TestCase of TestGroup_0 is instance of TestCase' do
          expect(@tg_0.test_cases[@tg_0.size - 1].instance_of?(Mkspec::TestCase)).to be(true)
        end
      end
    end
  end
end
