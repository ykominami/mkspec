# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  context 'call instance method of TestConf class' do
    before(:all) do
      @conf = Mkspec::TestConf.new( ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '', __FILE__, nil)
      @o = @conf.o
      @original_output_dir_pn = @o.original_output_dir_pn
      @original_output_dir = @o.original_output_dir
    end
    context '' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end
      it 'call get_path' , xcmd:1 do
        target_cmd_1 = 'mkspec'
        target_cmd_2 = nil
        _tmp, target_cmd_1_pn, target_cmd_2_pn = Mkspec::Util.get_path(@o.top_dir_pn, '.', target_cmd_1, target_cmd_2)
        expect(@o.top_dir_pn).to_not eq(nil)
        expect(target_cmd_1_pn).to eq(nil)
      end

      it 'call get_path' , xcmd:2 do
        target_cmd_1 = 'mkspec'
        target_cmd_2 = nil
        _tmp, target_cmd_1_pn, target_cmd_2_pn = Mkspec::Util.get_path(@o.top_dir_pn, 'bin', target_cmd_1, target_cmd_2)
        expect(@o.top_dir_pn).to_not eq(nil)
        expect(target_cmd_1_pn).to_not eq(nil)
      end
    end
  end
end
