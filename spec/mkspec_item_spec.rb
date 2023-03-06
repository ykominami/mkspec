# frozen_string_literal: true

require 'spec_helper_1'

logger_init( "./logs" )

RSpec.describe Mkspec do
  context 'call instance methods of Iem class' do
    before(:all) do
      @conf = TestHelp.make_testconf
      @ost = @conf.ost
    end
    context '' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        content_path = @ost.spec_test_test_misc_dir_pn.join("_content.txt")
        yaml_path = @ost.spec_test_test_misc_dir_pn.join("_a.yml")
        item = @conf._create_instance_of_item(content_path, yaml_path)
        @ret = item.result
      end

      it 'call result(String)' , xcmd: 1 do
        expect(@ret.class).to eq(String)
      end

      it 'call result' , xcmd: 2 do
        expect(@ret.size.zero?).to be(false)
      end
    end
  end
end
