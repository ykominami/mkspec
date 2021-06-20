# frozen_string_literal: true

require 'spec_helper_1'

RSpec.describe Mkspec do
  context 'call methods of TestGroup class' do
    before(:all) do
		  @conf = Mkspec::TestConf.new( ENV['MKSPEC_SPECIFIC_YAML_FNAME'], ENV['MKSPEC_GLOBAL_YAML_FNAME'], 'mkspec', '', __FILE__, nil)
      @o = @conf.o
      @original_output_dir_pn = @o.original_output_dir_pn
      @original_output_dir = @o.original_output_dir
      @test_case_args = Mkspec::Util.make_arg_of_add_test_case_of_testgroup
=begin
        {'size' => 1,
        'testgroup' => '',
        'tcase' => '',
        'tcase' => '',
        'test_1' => '',
        'test_1_value' => '',
        'test_1_message' => '',
        'test_1_tag' => '',
        'test_2' => '',
        'test_2_value' => '',
        'test_2_message' => '',
        'test_2_tag' => '',
        'extra' => '',
         } )
=end
    end
    context '' do
      before(:all) do
        Mkspec::STATE.change(Mkspec::SUCCESS, nil)
        @conf2 = @conf
        @tg_0 = @conf.create_instance_of_testgroup_0
        @tg_0_name_normalize = @o.tgroup_0_name_normalize
  #      @tg_1 = conf.create_instance_of_testgroup("mruby-mrubybridge", o.make_arg_basename)
      end
      it 'call to_s' , xcmd:1 do
        ret = @tg_0.to_s
        expect(ret).to eq(@tg_0_name_normalize)
      end
      context '' do
        before(:all) do 
          @conf.add_testcases(@tg_0, 1)
        end
        it 'call add_test_case_1' , xcmd:2 do
=begin
        size = 1
        testgroup = ''
        tcase = ''
        tcase = ''
        test_1 = ''
        test_1_value = ''
        test_1_message = ''
        test_1_tag = ''
        test_2 = ''
        test_2_value = ''
        test_2_message = ''
        test_2_tag = ''
        extra = ''
=end
        #@tg_0.add_test_case("#{testgroup}_#{tcase}", tcase, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra)
          expect(@tg_0.size).to eq(1)
        end
        it '' do
          expect(@tg_0.test_cases.size).to eq(1)
        end
        it '' do
          expect(@tg_0.test_cases[@tg_0.size - 1].instance_of?(Mkspec::TestCase)).to eq(true)
        end
      end
    end
  end
end
