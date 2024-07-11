# frozen_string_literal: true

require 'spec_helper_1'

log_dir = ENV.fetch('MKSPEC_LOG_DIR', "./test_data/logs")
logger_init(log_dir, level: :debug, stdout_flag: true) #1

RSpec.describe Mkspec::TestConf do
  context 'call instance method of TestConf class' do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
      @original_output_dir_pn = @ost.original_output_dir_pn
      @original_output_dir = @ost.original_output_dir
    end

    context 'STATE is SUCCESS' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      it 'call get_path', xcmd: 2 do
        target_cmd_1 = 'mkspec'
        target_cmd_2 = nil
        _tmp, target_cmd_1_pn, _target_cmd_2_pn = Mkspec::Util.get_path(@ost.output_data_top_dir_pn, 'bin', target_cmd_1, target_cmd_2)
        expect(@ost.top_dir_pn).not_to be_nil
        expect(target_cmd_1_pn).not_to be_nil
      end
    end
  end
end
