# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  include TestConf

  let(:conf) {TestConf::TestConf.new(ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '',  __FILE__, nil) }
  let(:o) { conf.o }

  context 'call methods of Iem class' do
    before(:each) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      content_path = o.spec_test_test_misc_dir_pn.join("_content.txt")
      yaml_path = o.spec_test_test_misc_dir_pn.join("_a.yml")
      @item = conf._create_instance_of_item(content_path, yaml_path)
      @ret = @item.result
    end

    it 'call result(String)' , xcmd:1 do
      expect(@ret.class).to eq(String)
    end

    it 'call result' , xcmd:2 do
      expect(@ret.size.zero?).to eq(false)
    end
  end
end
