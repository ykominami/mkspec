# frozen_string_literal: true

require 'spec_helper_1'
require 'pry'

logger_init( "./logs" )

RSpec.describe 'Mkspec::Util' do
  context 'get_file_content' do
    before(:all) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      @conf = TestHelp.make_testconf
      top_dir_yaml_pna, specific_yaml_pna, global_yaml_pna = TestHelp.adjust_paths
      @ret = Mkspec::Util.get_file_content(global_yaml_pna)
    end

    it 'get_file_content' , cmd: 0 do expect(@ret).not_to be_nil end
  end
  context 'extract_in_yaml_file' do
    before(:all) do
      @expected_hash_base = { "emails" => ["flower@mail.com",
                                           "garnet@mail.net", "peach@mail.org"],
                              "names" => ["Hanako", "Sumire", "Momoko"] }
    end
    context 'ENV["MKSPEC_SPECIFIC_YAML_FNAME"]' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @expected_hash_base = {
          "tecsgen_top_dir" => "/home/ykominami/repo/tecsgen/trunk",
          "asp_dir" => "/mnt/e/v/ext2/svn-toppers/asp/trunk",
          "asp3_dir" => "/mnt/e/v/ext2/svn-toppers/asp3/trunk",
          "log_dir" => "./logs",

          "original_output_root_dir" => "./test_data",
          "top_dir" => ".",
          "tsv_path_index" => 0,
          "tsv_path_array" => [
            "./test_data/test/misc/testlist-x.txt",
            "./test_data/test/misc/t.txt"
          ]
        }
      end
      context 'extract_in_yaml_file' do
        before(:all) do
          top_dir_yaml_pna, resolved_top_dir_yaml_pna, specific_yaml_pna, global_yaml_pna = TestHelp.adjust_paths
          Mkspec::STATE.change(Mkspec::SUCCESS, nil)
          @expected_ret_hash = @expected_hash_base
          @ret_hash = Mkspec::Util.extract_in_yaml_file(specific_yaml_pna)
        end

        it 'result' , tc: 1000, cmd: 1000 do
          expect(@ret_hash).to eq(@expected_ret_hash)
        end
      end

      context 'extract_in_yaml_file 2' do
        context 'YAML file and nil' do
          before(:all) do
            top_dir_yaml_pna, resolved_top_dir_yaml_pna, specific_yaml_pna, global_yaml_pna = TestHelp.adjust_paths
            Mkspec::STATE.change(Mkspec::SUCCESS, nil)
            @expected_ret_hash = nil
            @cret_hash = Mkspec::Util.extract_in_yaml_file(specific_yaml_pna)
          end

          it '@ret_hash' , cmd: 1010 do
            expect(@ret_hash).to eq(@expected_ret_hash)
          end
        end
      end
    end
  end

  context 'extract_in_yaml_file double' do
    context "File" do
      before(:all) do
        top_dir_yaml_pna, resolved_top_dir_yaml_pna, specific_yaml_pna, global_yaml_pna = TestHelp.adjust_paths
        specific_hash = Mkspec::Util.extract_in_yaml_file(specific_yaml_pna)
        @global_hash = Mkspec::Util.extract_in_yaml_file(global_yaml_pna, specific_hash)
      end

      it 'double' , cmd: 1100 do
        expect(@global_hash.class).to eq(Hash)
      end
    end
  end

  context "extract_in_yaml 3" do
    context "Hash and string(yaml)" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        yaml_str = ''
        hash = {
          "make_arg" => "make_cmdline_1",
          "tecsgen_base" => "<%= tecsgen_top_dir %>/tecsgen/tecsgen",
          "tecsgen_cmd" => "tecsgen",
          "tecsmerge_cmd" => "tecsmerge",
          "tecsgen_cmd_path" => "<%= tecsgen_base %>/tecsgen",
          "tecsmerge_cmd_path" => "<%= tecsgen_base %>/<%= tecsmerge_cmd %>",
          "tecsgen_path" => "<%= tecsgen_base %>",
          "tecspath" => "<%= tecsgen_base %>/tecslib",
          "data_dir_0" => "_DATA",
          "sub_data_dir_1" => "hier4",
          "sub_data_dir_2" => "hier1",
          "root_output_dir" => "test_auto",
          "original_output_dir" => "_DATA/hier4",
          "test_case_dir" => "test_case",
          "tad_dir_index" => 0,
          "tad_dir_array" => ["template_and_data", "template_and_data_2"],
          "script_dir_index" => 0,
          "script_dir_array" => ["script", "script_2"],
          "tecsgen_top_dir" => "/home/ykominami/repo/ns4-tecsgen",
          "asp_dir" => "/mnt/e/v/ext2/svn-toppers/asp/trunk",
          "asp3_dir" => "/mnt/e/v/ext2/svn-toppers/asp3/trunk",
          "top_dir" => "/home/ykominami/repo/mkspec",
          "tsv_path_index" => 0,
          "tsv_path" => ["/home/ykominami/repo/mkspec/test_auto/misc/testlist-x.txt",
                         "/home/ykominami/repo/mkspec/test_auto/misc/t.txt"]
        }
        @global_hash = Mkspec::Util.extract_in_yaml(yaml_str, hash)
      end

      it 'double' , cmd: 1200 do
        expect(@global_hash.class).to eq(Hash)
      end
    end
  end
  context 'extract_in_yaml' do
    context 'empty string and nil' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        yaml = ""
        hs = nil
        @expected_ret_hash = {}
        @ret_hash = Mkspec::Util.extract_in_yaml(yaml, hs)
      end

      it 'result' , k: "extract_in_yaml", cmd: 2000 do
        expect(@ret_hash).to eq(@expected_ret_hash)
      end
    end

    context 'empty string and not appropriate hash' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        yaml = ''
        hs = { "itemx" => "ItemX" }
        @expected_ret_hash = {}
        @ret_hash = Mkspec::Util.extract_in_yaml(yaml, hs)
      end
      it 'result' , k: "extract_in_yaml", cmd: 2020 do
        expect(@ret_hash).to eq(@expected_ret_hash)
      end
    end

    context 'string and appropriate hash' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        yaml = <<~ENO_OF_BLOCK
          itemx2: <%= itemx %>_A
          itemx3: <%= itemx2 %>_B
        ENO_OF_BLOCK
        @expected_ret_hash = { "itemx2" => "ItemX_A" , "itemx3" => "ItemX_A_B" }
        hs = { "itemx" => "ItemX" }
        @ret_hash = Mkspec::Util.extract_in_yaml(yaml, hs)
      end
      it 'result' , k: "extract_in_yaml", cmd: 2030 do
        expect(@ret_hash).to eq(@expected_ret_hash)
      end
    end
  end

  context 'extract_with_eruby' do
    context 'extract_with_eruby empty string and empty hash' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @content = ""
        @hash = {}
      end

      it 'result' , cmd: 200 do
        expect {
          @ret = Mkspec::Util.extract_with_eruby(@content, @hash)
        }.to raise_error(StandardError)
      end
    end
    context 'extract_with_eruby not empty string and appropriate hash' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @content = <<~END_OF_BLOCK
          <%= itemx %>
        END_OF_BLOCK
        @expected_result = nil
        @hash = { itemx: "ItemX" }
        @ret = Mkspec::Util.extract_with_eruby(@content, @hash)
      end

      it 'result' , cmd: 201 do
        expect(@ret).not_to eq(@expected_result)
      end
    end

    context 'extract_with_eruby not empty string and not appropriate hash' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @content = <<~END_OF_BLOCK
          <%= itemx %>
        END_OF_BLOCK
        @hash = { itemx_2: "ItemX" }
      end
      it 'result' , cmd: 202 do
        expect {
          @ret = Mkspec::Util.extract_with_eruby(@content, @hash)
        }.to raise_error(StandardError)
      end
    end
  end

  context 'tag_analyze' do
    context 'string and appropriate hash 1' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        yaml = <<~END_OF_BLOCK
          names:
            - Hanako
            - Sumire
            - Momoko
          emails:
            - flower@mail.com
            - garnet@mail.net
            - peach@mail.org
        END_OF_BLOCK
        @expected_result = []
        @ret_array = Mkspec::Util.tag_analyze_for_contents(yaml)
      end

      it 'result' , cmd: 500 do
        expect(@ret_array).to eq(@expected_result)
      end
    end

    context 'string and appropriate hash 2' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        yaml = <<~END_OF_BLOCK
          itemx2: <%= itemx %>_A
          itemx3: <%= itemx2 %>_B
        END_OF_BLOCK
        @expected_result = ["itemx", "itemx2"]
        @ret_array = Mkspec::Util.tag_analyze_for_contents(yaml)
      end

      it 'result' , cmd: 501 do
        expect(@ret_array).to eq(@expected_result)
      end
    end
  end

  context 'adjust_hash' do
    context 'nil' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        hash = nil
        @expected_hash = {}
        @ret_hash = Mkspec::Util.adjust_hash(hash)
      end

      it 'result' , cmd: 601 do
        expect(@ret_hash).to eq(@expected_hash)
      end
    end

    context '{}' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        hash = {}
        @expected_hash = {}
        @ret_hash = Mkspec::Util.adjust_hash(hash)
      end

      it 'result' , cmd: 602 do
        expect(@ret_hash).to eq(@expected_hash)
      end
    end

    context 'hash size 1' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        hash = { "a" => "A" }
        @expected_hash = hash
        @ret_hash = Mkspec::Util.adjust_hash(hash)
      end

      it 'result' , cmd: 603 do
        expect(@ret_hash).to eq(@expected_hash)
      end
    end
  end
end
