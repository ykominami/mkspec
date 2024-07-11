# frozen_string_literal: true

require "spec_helper_1"
require "debug"

logger_init_x

RSpec.describe "Mkspec::Util" do
  context "adjust_paths" do
    ret = Mkspec::Util.adjust_paths
    top_dir_yaml_file, resolved_top_dir_yaml_file, specific_yaml_file, global_yaml_file = ret
    it "The number of elements in the array is four.", cmd: 1 do
      expect(ret.size).to eq(4)
    end

    it "top_dir_yaml_file is an array with 3 elements.", cmd: 1 do
      expect(top_dir_yaml_file.size).to eq(3)
    end

    it "The third element of array top_dir_yaml_file is an instance of the Pathname class.", cmd: 1 do
      expect(top_dir_yaml_file[2]).to be_a(Pathname)
    end

    it "resolved_top_dir_yaml_file is an array with 3 elements.", cmd: 1 do
      expect(resolved_top_dir_yaml_file.size).to eq(3)
    end

    it "The third element of array resolved_top_dir_yaml_file is an instance of the Pathname class.", cmd: 1 do
      expect(resolved_top_dir_yaml_file[2]).to be_a(Pathname)
    end

    it "specific_yaml_file is an array with 3 elements.", cmd: 1 do
      expect(specific_yaml_file.size).to eq(3)
    end

    it "The third element of array specific_yaml_file is an instance of the Pathname class.", cmd: 1 do
      expect(specific_yaml_file[2]).to be_a(Pathname)
    end

    it "global_yaml_file is an array with 3 elements.", cmd: 1 do
      expect(global_yaml_file.size).to eq(3)
    end

    it "The third element of array global_yaml_file is an instance of the Pathname class.", cmd: 1 do
      expect(global_yaml_file[2]).to be_a(Pathname)
    end
  end

  context "get_file_content" do
    before(:all) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
    end

    # conf = TestHelp.make_testconf
    _, _, global_yaml_file, = Mkspec::Util.adjust_paths
    let(:ret) { Mkspec::Util.get_file_content(global_yaml_file[2]) }

    it "get_file_content", cmd: 0 do
      expect(ret).not_to be_nil
    end
  end

  context "extract_in_yaml_file" do
    before(:all) do
      @expected_hash_base = { "emails" => ["flower@mail.com",
                                           "garnet@mail.net", "peach@mail.org"],
                              "names" => ["Hanako", "Sumire", "Momoko"] }
    end

    context 'ENV["MKSPEC_SPECIFIC_YAML_FNAME"]' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @expected_hash_base = {
          "cmd" => "all",
          "limit" => 6,
          "start_char" => "a",
          "tecsgen_top_dir" => "/home/ykominami/repo_ykominami/tecsgen",
          "asp_dir" => "/mnt/e/v/ext2/svn-toppers/asp/trunk",
          "asp3_dir" => "/mnt/e/v/ext2/svn-toppers/asp3/trunk",

          "log_dir" => "/home/ykominami/repo_ykominami/mkspec_output/logs",
          "original_output_root_dir" => "/home/ykominami/repo_ykominami/mkspec_output",
          "top_dir" => "/home/ykominami/repo_ykominami/mkspec_data",
          "tsv_path_index" => 0,
          "tsv_path_array" => [
            "/home/ykominami/repo_ykominami/mkspec_data/test/misc/testlist-x.txt",
            "/home/ykominami/repo_ykominami/mkspec_data/test/misc/t.txt"
          ]
        }
      end

      context "extract_in_yaml_file" do
        before(:all) do
          _, _, @specific_yaml_file, = Mkspec::Util.adjust_paths
          Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        end

        let(:expected_ret_hash) { @expected_hash_base }
        let(:ret_hash) { Mkspec::Util.extract_in_yaml_file(@specific_yaml_file.pathname) }

        it "result", cmd: 1000, tc: 1000 do
          expect(ret_hash).to eq(expected_ret_hash)
        end
      end

      context "extract_in_yaml_file 2" do
        context "YAML file and nil" do
          before(:all) do
            _, _, @specific_yaml_file, = Mkspec::Util.adjust_paths
            Mkspec::STATE.change(Mkspec::SUCCESS, nil)
          end

          let(:expected_ret_hash) { nil }
          let(:ret_hash) { Mkspec::Util.extract_in_yaml_file(@specific_yaml_file.pathname) }

          it "@ret_hash", cmd: 1010 do
            expect(ret_hash).not_to eq(expected_ret_hash)
          end
        end
      end
    end
  end

  context "extract_in_yaml_file double" do
    context "File" do
      before(:all) do
        _, _, @specific_yaml_file, @global_yaml_file = Mkspec::Util.adjust_paths
      end

      let(:specific_hash) { Mkspec::Util.extract_in_yaml_file(@specific_yaml_file.pathname) }
      let(:global_hash) { Mkspec::Util.extract_in_yaml_file(@global_yaml_file.pathname, specific_hash) }

      it "double", cmd: 1100 do
        expect(global_hash.class).to eq(Hash)
      end
    end
  end

  context "extract_in_yaml 3" do
    context "Hash and string(yaml)" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:yaml_str) { "" }
      let(:hash) do
        {
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
      end
      let(:global_hash) { Mkspec::Util.extract_in_yaml(yaml_str, hash) }

      it "double", cmd: 1200 do
        expect(global_hash.class).to eq(Hash)
      end
    end
  end

  context "extract_in_yaml" do
    context "empty string and nil" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:yaml) { "" }
      let(:hs) { nil }
      let(:expected_ret_hash) { {} }
      let(:ret_hash) { Mkspec::Util.extract_in_yaml(yaml, hs) }

      it "result", cmd: 2000, k: "extract_in_yaml" do
        expect(ret_hash).to eq(expected_ret_hash)
      end
    end

    context "empty string and not appropriate hash" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:yaml) { "" }
      let(:hs) { { "itemx" => "ItemX" } }
      let(:expected_ret_hash) { {} }
      let(:ret_hash) { Mkspec::Util.extract_in_yaml(yaml, hs) }

      it "result", cmd: 2020, k: "extract_in_yaml" do
        expect(ret_hash).to eq(expected_ret_hash)
      end
    end

    context "string and appropriate hash" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:yaml) do
        <<~ENO_OF_BLOCK
          itemx2: <%= itemx %>_A
          itemx3: <%= itemx2 %>_B
        ENO_OF_BLOCK
      end
      let(:expected_ret_hash) { { "itemx2" => "ItemX_A", "itemx3" => "ItemX_A_B" } }
      let(:hs) { { "itemx" => "ItemX" } }
      let(:ret_hash) { Mkspec::Util.extract_in_yaml(yaml, hs) }

      it "result", cmd: 2030, k: "extract_in_yaml" do
        expect(ret_hash).to eq(expected_ret_hash)
      end
    end
  end

  context "extract_with_eruby" do
    context "extract_with_eruby empty string and empty hash" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:content) { "" }
      let(:hash) { {} }

      it "result", cmd: 200 do
        expect do
          Mkspec::Util.extract_with_eruby(content, hash)
        end.to raise_error(StandardError)
      end
    end

    context "extract_with_eruby not empty string and appropriate hash" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:content) do
        <<~END_OF_BLOCK
          <%= itemx %>
        END_OF_BLOCK
      end
      let(:expected_result) { nil }
      let(:hash) { { itemx: "ItemX" } }
      let(:ret)  { Mkspec::Util.extract_with_eruby(content, hash) }

      it "result", cmd: 201 do
        expect(ret).not_to eq(expected_result)
      end
    end

    context "extract_with_eruby not empty string and not appropriate hash" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:content) do
        <<~END_OF_BLOCK
          <%= itemx %>
        END_OF_BLOCK
      end
      let(:hash) { { itemx_2: "ItemX" } }

      it "result", cmd: 202 do
        expect do
          Mkspec::Util.extract_with_eruby(content, hash)
        end.to raise_error(StandardError)
      end
    end
  end

  context "tag_analyze" do
    context "string and appropriate hash 1" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:yaml) do
        <<~END_OF_BLOCK
          names:
            - Hanako
            - Sumire
            - Momoko
          emails:
            - flower@mail.com
            - garnet@mail.net
            - peach@mail.org
        END_OF_BLOCK
      end
      let(:expected_result) { [] }
      let(:ret_array) { Mkspec::Util.tag_analyze_for_contents(yaml) }

      it "result", cmd: 500 do
        expect(ret_array).to eq(expected_result)
      end
    end

    context "string and appropriate hash 2" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:yaml) do
        <<~END_OF_BLOCK
          itemx2: <%= itemx %>_A
          itemx3: <%= itemx2 %>_B
        END_OF_BLOCK
      end
      let(:expected_result) { ["itemx", "itemx2"] }
      let(:ret_array) { Mkspec::Util.tag_analyze_for_contents(yaml) }

      it "result", cmd: 501 do
        expect(ret_array).to eq(expected_result)
      end
    end
  end

  context "adjust_hash" do
    context "nil" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:hash) { nil }
      let(:expected_hash) { {} }
      let(:ret_hash) { Mkspec::Util.adjust_hash(hash) }

      it "result", cmd: 601 do
        expect(ret_hash).to eq(expected_hash)
      end
    end

    context "{}" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:hash) { {} }
      let(:expected_hash) { {} }
      let(:ret_hash) { Mkspec::Util.adjust_hash(hash) }

      it "result", cmd: 602 do
        expect(ret_hash).to eq(expected_hash)
      end
    end

    context "hash size 1" do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
      end

      let(:hash) { { "a" => "A" } }
      let(:expected_hash) { hash }
      let(:ret_hash) { Mkspec::Util.adjust_hash(hash) }

      it "result", cmd: 603 do
        expect(ret_hash).to eq(expected_hash)
      end
    end
  end
end
