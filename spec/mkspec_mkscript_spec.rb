# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Mkspec do
  include TestConf

  let(:original_output_dir_pn) { Pathname.new('_DATA') + 'hier10' }
  let(:original_output_dir) { original_output_dir_pn.to_s }
  let(:target_cmd_1) { 'tecsgen' }
  let(:target_cmd_2) { 'tecsmerge' }
  #                                     global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path, original_output_dir = nil
  let(:conf) { TestConf::TestConf.new( ENV['GLOBAL_YAML'], target_cmd_1, target_cmd_2, __FILE__, original_output_dir) }
  let(:o) { conf.o }
  let(:tsv_lines) { o.tsv_lines }
#
  context 'make script' do
    context 'Mkscript-all' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        @conf = conf
        @o = o
      end

      # test_auto/_DATA/hier9
      #                      /test_case(生成したspecファイルを実行するときに参照)
      #                      /template_and_data(出力先)
      #                      /script(出力先)
      it 'create all files' , ms:11 do
        argv = %W[-g #{@o[Mkspec::GLOBAL_YAML_FNAME]} -o #{@o.output_dir} -t #{@o.tsv_fname} -c all -s #{@o.start_char}
               -l #{@o.limit} -x #{@o.original_output_dir} -y #{@o.target_cmd_1_pn} -z #{@o.target_cmd_2_pn}
               ]
        mkscript = @conf.create_instance_of_mkscript(argv)
        expect(Mkspec::STATE.success?).to eq(true)
      end

      it 'create all files 2' , ms:12 do
        argv = %W[-g #{@o[Mkspec::GLOBAL_YAML_FNAME]} -o #{@o.output_dir} -t #{@o.tsv_fname} -c all -s #{@o.start_char}
               -l #{@o.limit} -x #{@o.original_output_dir} -y #{@o.target_cmd_1_pn} -z #{@o.target_cmd_2_pn}
              ]
        mkscript = @conf.create_instance_of_mkscript(argv)
        ret = mkscript.create_files
        expect(ret).to eq(true)
#        expect(ret).to eq(false)
      end
    end

    context 'Mkscript-tad' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        @conf = conf
        @o = o
      end
      # test_auto/_DATA/hier9
      #                      /test_case(生成したspecファイルを実行するときに参照)
      #                      #/template_and_data(出力先)
      #                      /template_and_data_2(今回の出力先)　ここに出力するだけ
      #                      /script(出力先)
      it 'create template and data' , ms:2 do
        argv = %W[-g #{@o[Mkspec::GLOBAL_YAML_FNAME]} -o #{@o.output_dir} -i #{@o.tad_2_dir} -t #{@o.tsv_fname} -c tad
               -s #{@o.start_char} -l #{@o.limit} -x #{@o.original_output_dir} -y #{@o.target_cmd_1_pn} -z #{@o.target_cmd_2_pn}
              ]
        mkscript = @conf.create_instance_of_mkscript(argv)
        ret = mkscript.create_files

        expect(ret).to eq(true)
      end
    end

    context 'Mkscript-script' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname
        @conf = conf
        @o = o
      end
      # test_auto/_DATA/hier9
      #                      /test_case(生成したspecファイルを実行するときに参照)
      #                      #/template_and_data(出力先)
      #                      /template_and_data_2(今回の参照先)　ここは参照するだけ
      #                      #/script(出力先)
      #                      /script_3 (今回の出力先)　ここに出力するだけ
      it 'create spec files from files under template_and_data_2' ,ms:3 do
        argv = %W[-g #{@o[Mkspec::GLOBAL_YAML_FNAME]} -o #{@o.output_dir} -i #{@o.tad_2_dir} -d #{o.script_3_dir}
               -t #{@o.tsv_fname} -c spec -s #{@o.start_char} -l #{@o.limit} -x #{@o.original_output_dir}
               -y #{@o.target_cmd_1_pn} -z #{@o.target_cmd_2_pn}
              ]
        mkscript = conf.create_instance_of_mkscript(argv)
        ret = mkscript.create_files

        expect(ret).to eq(true)
      end
    end

    context 'Mkscript-script' do
      before(:each) do
        tsv_fname = o.misc_tsv_fname_2
        @conf = conf
        @o = o
      end
      # test_auto/_DATA/hier9
      #                      /test_case(生成したspecファイルを実行するときに参照)
      #                      #/template_and_data(出力先)
      #                      /template_and_data_2(今回の参照先)　ここは参照するだけ
      #                      #/script(出力先)
      #                      /script_3 (今回の出力先)　ここに出力するだけ
      it 'create spec files from files under template_and_data_2' ,ms:4 do
        argv = %W[-g #{@o[Mkspec::GLOBAL_YAML_FNAME]} -o #{@o.output_dir} -i #{@o.tad_2_dir} -d #{o.script_3_dir}
               -t #{@o.tsv_fname} -c all -s #{@o.start_char} -l #{@o.limit} -x #{@o.original_output_dir}
               -y #{@o.target_cmd_1_pn} -z #{@o.target_cmd_2_pn}
              ]
        mkscript = conf.create_instance_of_mkscript(argv)
        ret = mkscript.create_files

        expect(ret).to eq(true)
      end
    end
  end
end
