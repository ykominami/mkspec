# frozen_string_literal: true

require "spec_helper_1"

begin
  require "debug"
rescue StandardError => exc
  puts exc.message
end

logger_init_x

RSpec.describe "Mkspec::Util" do
  context "with adjust_files" do
    ret = Mkspec::Util.adjust_files
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

  context "with get_file_content" do
    before(:all) do
      Mkspec::STATE.change(Mkspec::SUCCESS, nil)
    end

    # conf = TestHelp.make_testconf
    _, _, global_yaml_file, = Mkspec::Util.adjust_files
    let(:ret) { Mkspec::Util.get_file_content(global_yaml_file[2]) }

    it "get_file_content", cmd: 0 do
      expect(ret).not_to be_nil
    end
  end

  context "with extract_in_yaml_file double" do
    context "when File" do
      before(:all) do
        _, _, @specific_yaml_file, @global_yaml_file = Mkspec::Util.adjust_files
      end

      let(:specific_hash) { Mkspec::Util.extract_in_yaml_file(@specific_yaml_file.pathname) }
      let(:global_hash) { Mkspec::Util.extract_in_yaml_file(@global_yaml_file.pathname, specific_hash) }

      it "double", cmd: 1100 do
        expect(global_hash.class).to eq(Hash)
      end
    end
  end

  context "with extract_in_yaml" do
    context "when empty string and nil" do
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

    context "when empty string and not appropriate hash" do
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

    context "when string and appropriate hash" do
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

  context "with extract_with_eruby" do
    context "when extract_with_eruby empty string and empty hash" do
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

    context "when extract_with_eruby not empty string and appropriate hash" do
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

    context "when extract_with_eruby not empty string and not appropriate hash" do
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

  context "with tag_analyze" do
    context "when string and appropriate hash 1" do
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

    context "when string and appropriate hash 2" do
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

  context "with adjust_hash" do
    context "when nil" do
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

    context "when {}" do
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

    context "when hash size 1" do
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
