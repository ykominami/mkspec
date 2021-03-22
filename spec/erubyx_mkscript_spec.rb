# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Erubyx do
  include UtilHelper
  include TestConf

  let(:original_output_dir_pn) { Pathname.new('_DATA') + 'hier9' }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:target_cmd_1) { 'tecsgen' }
  let(:target_cmd_2) { 'tecsmerge' }
  let(:conf) { TestConf::TestConf.new( target_cmd_1, target_cmd_2, __FILE__, original_output_dir) }
  let(:o) { conf.o }
  let(:tsv_lines) { o.tsv_lines }
#
  context 'make script' do
    context 'Mkscript-a' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        argv = %W[-d #{o.output_dir} -t #{o.tsv_fname} -c all -s #{o.start_char} -l #{o.limit}]
        @mkscript = conf.create_instance_of_mkscript(argv)

        @ret = @mkscript.create_files
      end
      it 'create instance' , ms:1 do
        expect(@ret).to eq true
      end
    end

    context 'Mkscript-notemp' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        argv = %W[-d #{o.output_dir} -t #{o.tsv_fname} -c notemp -s #{o.start_char} -l #{o.limit}]
        @mkscript = conf.create_instance_of_mkscript(argv)

        @ret = @mkscript.create_files
      end
      it 'create instance' ,ms:2 do
        expect(@ret).to eq true
      end
    end
  end
end
