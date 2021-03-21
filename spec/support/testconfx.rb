# frozen_string_literal: true

module TestConfx
  require 'pathname'
  require 'ostruct'

  class TestConfx
    attr_reader :o

    def initialize(spec_dir)
      o = OpenStruct.new
      o.spec_pn = Pathname.new(spec_dir)
      o.spec_dir = o.spec_pn.to_s
      o.top_dir_pn = o.spec_pn.parent
      o.top_dir = o.top_dir_pn.to_s
      o.test_case_dir_pn = o.top_dir_pn + "test_auto" + "spec" + "test_data2" + "test_case"
=begin
      o.test_dir_pn = o.spec_pn + 'test'
      o.test_cmd_pn = o.spec_pn + 'bin' + 'cmd.sh'
      o._test_data_dir_pn = o.test_dir_pn + '_data'
      o.misc_dir_pn = o.test_dir_pn + 'misc'
      o.tsv_fname = 'testlist-x.txt'
      o.misc_tsv_fname = o.misc_dir_pn + o.tsv_fname
      o.output_root_dir_pn = o.spec_pn.parent + 'test_output'
      o.output_root_dir = o.output_root_dir_pn.to_s
      o.output_dir_pn = o.output_root_dir_pn + output_dir
      o.output_dir = o.output_dir_pn.to_s
      o.output_template_and_data_dir_pn = o.output_dir_pn + "template_and_data"
      o.output_template_and_data_dir = o.output_template_and_data_dir_pn.to_s
      o.output_script_dir_pn = o.output_dir_pn + "script"
      o.output_script_dir = o.output_script_dir_pn.to_s
      o.output_test_case_dir_pn = o.output_dir_pn + "test_case"
      o.output_test_case_dir = o.output_test_case_dir_pn.to_s

      o._output_dir_pn = o.test_dir_pn + '_output'
      o._output_dir = o._output_dir_pn.to_s
      o._test_case_dir_pn = o._output_dir_pn + "test_case"
      o._test_case_dir = o._test_case_dir_pn.to_s
      o._template_and_data_dir_pn = o._output_dir_pn + "template_and_data"
      o._template_and_data_dir = o._template_and_data_dir_pn.to_s
      o._script_dir_pn = o._output_dir_pn + "script"
      o._script_dir = o._script_dir_pn.to_s
      o.content_fname = 'content.txt'
      o.testdata_fname = 'testdata.txt'
      o.yaml_fname = 'a.yml'
      o._yaml_fname = 'a.yml'
      o._config = Erubyx::Config.new(o.spec_dir, o._output_dir)
      o._data_dir_pn = o._template_and_data_dir_pn + 'a'
    #
      o.data_dir_pn = o.output_template_and_data_dir_pn + 'a'
    #
      o.config_0 = Erubyx::Config.new(o.spec_dir, o.output_dir).setup
      o.asp_dir = o.test_dir_pn+ "asp" + "tecs"
      o.asp3_dir = o.test_dir_pn + "asp3"
      o.target_cmd_1 = 'tecsgen'
      o.target_cmd_2 = 'tecsmerge'
      o.start_char = 'a'
      o.limit = 6
      #config, test_cmd, target_cmd_1, target_cmd_2
      o.conf = UtilHelper.make_conf(o.config_0, o.test_cmd_pn, o.target_cmd_1, o.target_cmd_2)
      o.test_1 = 'test_1'
      o.test_2 = 'test_2'
      o.format_fname = 'format.txt'
=end
      @o = o
    end

    def make_target_dir(target_parent_dir, num)
      ret = ''
      if target_parent_dir
        target_parent_pn = Pathname.new(target_parent_dir)
        ret = if num
                target_parent_pn + num.to_s
              else
                target_parent_pn
              end
      elsif num
        ret = Pathname.new(num.to_s)
      end

      ret.to_s
    end

    def make_result_file_path(target_dir, result)
      ret = ''
      if target_dir
        target_pn = Pathname.new(target_dir)
        ret = if result
                target_pn + result
              else
                target_pn
              end
      elsif result
        result_pn = Pathname.new(result)
        ret = result_pn
      end

      ret.to_s
    end

    def make_target_dir_and_result_file_path(target_parent_dir, num, result)
      target_dir = make_target_dir(target_parent_dir, num)
      result_file_path = make_result_file_path(target_dir, result)

      [target_dir, result_file_path]
    end

    def make_args( target_dir, result, optx, *param_name )
      params = param_name.join(" ")

      "#{@cmd_path} #{@test_data_dir} #{result} #{@tecsgen} #{target_dir} #{optx} #{params}"
    end

  end
end