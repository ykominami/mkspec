# frozen_string_literal: true

require 'spec_helper'
require 'pry'
require 'pp'

RSpec.describe 'util', type: :aruba do
  include TestConf

  context 'get_file_content' do
    before(:each) do
      @ret = Mkspec::Util.get_file_content(ENV['GLOBAL_YAML_FNAME'])
    end

    it 'get_file_content' , cmd:0 do expect(@ret).not_to eq(nil) end
  end

  context 'extract_in_yaml_file' do
    before(:each) do
      str = ""
      @ret = Mkspec::Util.extract_in_yaml_file(ENV['GLOBAL_YAML_FNAME'])
    end

    it 'result' , cmd:10 do
      expect(@ret).not_to eq(nil)
    end
  end
end
