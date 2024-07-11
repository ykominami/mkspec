# frozen_string_literal: true

require 'spec_helper_1'

logger_init_x

RSpec.describe Mkspec do
  context 'call instance methods of Iem class' do
    context '' do
      before(:each) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:conf) { TestHelp.make_testconf }
      let(:ost) { conf.ost }
      let(:content_path) { ost.spec_test_test_misc_dir_pn.join("_content.txt") }
      let(:yaml_path) { ost.spec_test_test_misc_dir_pn.join("_a.yml") }
      let(:item) { conf._create_instance_of_item(content_path, yaml_path) }
      let(:ret) { item.result }

      it 'call result(String)', xcmd: 1 do
        expect(ret.class).to eq(String)
      end

      it 'call result', xcmd: 2 do
        expect(ret.empty?).to be(false)
      end
    end
  end
end
