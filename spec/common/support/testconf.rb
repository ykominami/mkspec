# frozen_string_literal: true

module Mkspec
  require "pathname"
  require "ostruct"
  require "clitest"

  class TestConf
    attr_reader :ost

    def initialize(top_dir_yaml, resolved_top_dir_yaml, specific_yaml, global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path)
      @globalconfig = Mkspec::GlobalConfig.new(top_dir_yaml, resolved_top_dir_yaml, specific_yaml, global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path)
      @ost = @globalconfig.ost
      raise unless @ost.data_top_dir
      raise unless @ost.output_data_top_dir
      raise unless @ost.output_dir

      setup(@ost)

      raise unless @ost.data_top_dir
      raise unless @ost.output_data_top_dir
      raise unless @ost.output_dir
    end

    def setup_for_test_specific_data(ost)
      ost._output_dir_pn = ost.test_root_dir_pn.join("_output")
      ost._output_dir = ost._output_dir_pn.to_s
      ost._output_data_top_dir_pn = ost.test_root_dir_pn.join("_output")
      ost._output_data_top_dir = ost._output_dir_pn.to_s

      ost._test_case_dir_pn = ost._output_dir_pn.join("test_case")
      ost._test_case_dir = ost._test_case_dir_pn.to_s
      ost._template_and_data_dir_pn = ost._output_dir_pn.join("template_and_data")
      ost._template_and_data_dir = ost._template_and_data_dir_pn.to_s
      ost._script_dir_pn = ost._output_dir_pn.join("script")
      ost._script_dir = ost._script_dir_pn.to_s
      ost._yaml_fname = "a.yml"
      ost._data_dir_pn = ost._template_and_data_dir_pn.join("a")
    end

    def setup(ost)
      raise unless ost.output_data_top_dir

      setup_for_test_specific_data(ost)
      ost.data_dir_pn = ost.output_template_and_data_dir_pn.join("a")
      ost.tad_2_dir = "template_and_data_2"
      ost.script_3_dir = "script_3"
      ost.start_char = "a"
      ost.limit = 6
      ost.test_1 = "test_1"
      ost.test_2 = "test_2"
      ost.format_fname = "format.txt"
      ost.number_of_testgroup = 59
      ost.number_of_testscript = 19
      ost.number_of_testgroup_of_first_testscript = 3
      ost.tgroup_0_name = "mruby-MrubyBridge"
      ost.tgroup_0_name_normalize = "mruby_MrubyBridge"
      ost.cmdline_0 = Clitest::Cmdline.new(nil, nil, ost.target_parent_dir_pn, ost.target_cmd_1_pn)
      @globalconfig.arrange(ost)
    end

    def _mkscript
      _config
      @ost._mkscript = Mkspec::Mkscript.new
      cmd = "all"
      # "tad"
      # "spec"
      # "all-2"
      # "tad-2"
      # "spec-2"
      @ost._mkscript.init_sub(@globalconfig, @ost._config, @globalconfig.tsv_path, @ost.tad_dir,  @ost.start_char, @ost.limit, @globalconfig.make_arg_x, cmd)
      @ost._mkscript.create_files
    end

    def mkscript_0
      config_0
      @ost.mkscript_0 = Mkspec::Mkscript.new
      @ost.mkscript_0.init_sub(@ost._config, @globalconfig.tsv_path, @ost.tad_dir,  @ost.start_char, @ost.limit, @globalconfig.make_arg_x)
    end

    def _config
      @ost._config = Mkspec::Config.new(@ost.spec_dir, @ost.data_top_dir, @ost._output_data_top_dir, @ost._output_dir, nil,
                                        nil).setup
    end

    def config_0
      @ost.config_0 = Mkspec::Config.new(@ost.spec_dir, @ost.data_top_dir, @ost.output_dir, nil, nil).setup
    end

    def make_script_name(name)
      %(#{name}_spec.rb)
    end

    def make_absolute_target_dir(target_parent_dir, test_case_dir = nil)
      absolute_path = ""
      if target_parent_dir
        target_parent_pn = Pathname.new(target_parent_dir)
        absolute_path = if test_case_dir && test_case_dir !~ /^\s*$/
                          target_parent_pn.join(test_case_dir).realpath
                        else
                          target_parent_pn.realpath
                        end
      elsif test_case_dir && test_case_dir !~ /^\s*$/
        absolute_path = Pathname.new(test_case_dir.to_s).realpath
      end

      absolute_path.to_s
    end

    def make_result_file_path(target_dir, result)
      ret = ""
      if target_dir
        target_pn = Pathname.new(target_dir)
        ret = if result
                target_pn.join(result)
              else
                target_pn
              end
      elsif result
        result_pn = Pathname.new(result)
        ret = result_pn
      end

      ret.to_s
    end

    def make_absolute_target_dir_and_result_file_path(target_parent_dir, test_case_dir, result)
      absolute_target_dir = make_absolute_target_dir(target_parent_dir, test_case_dir)
      result_file_path = make_result_file_path(absolute_target_dir, result)

      [absolute_target_dir, result_file_path]
    end

    def create_instance_of_config
      # raise unless @ost.spec_dir
      raise unless @ost.data_top_dir
      raise unless @ost.output_data_top_dir
      raise unless @ost.output_dir

      Mkspec::Config.new(@ost.spec_dir, @ost.data_top_dir, @ost.output_data_top_dir, @ost.output_dir, nil, nil).setup
    end

    def _create_instance_of_config
      Mkspec::Config.new(@ost.spec_dir, @ost.data_top_dir, @ost.output_data_top_dir, @ost._output_dir, nil, nil).setup
    end

    def create_instance_of_root
      yml_path = Pathname.new("a").join(@ost.yaml_fname).to_s
      #      yml_path = @ost.config_0.make_path_under_template_and_data_dir(Pathname.new("a").join(@ost.yaml_fname))
      Mkspec::Root.new(yml_path, @ost.config_0)
    end

    def _create_instance_of_root
      _mkscript
      #      yml_path = @ost._config.make_path_under_template_and_data_dir(Pathname.new("a").join(@ost.yaml_fname))
      unless Util.not_empty_string?(@ost.yaml_fname)
        raise(Mkspec::MkspecDebugErrorunless,
              "testconf.rb _create_instance_of @ost.yaml_fname=#{@ost.yaml_fname}")
      end
      #yml_path = @ost.spec_test_test_misc_dir_pn.join("a.yml").to_s
      yml_path = @ost._config.make_path_under_template_and_data_dir("a").join("a.yml").to_s
      # yml_path = Pathname.new("a").join(@ost.yaml_fname).to_s
      Util.dump_var(:yml_path, "#{yml_path}|")
      Mkspec::Root.new(yml_path, @ost._config)
    end

    def create_instance_of_item(content_path, yaml_path)
      level = 1
      tag = "make_arg_data_flat"
      hash = {}
      #              (size,  name, outer_hash,   content_path, yaml_path, config)
      # @ost._config.setup
      _mkscript
      Mkspec::Item.new(level, 0, tag, hash, content_path, yaml_path, @ost._config)
    end

    def _create_instance_of_item(content_path, yaml_path)
      level = 1
      tag = "make_arg_data_flat"
      hash = {}
      #              (size,  name, outer_hash,   content_path, yaml_path, config)
      #_config
      #@ost._config.setup
      _mkscript
      Mkspec::Item.new(level, 0, tag, hash, content_path, yaml_path, @ost._config)
    end

    def create_instance_of_setting
      testscript = create_instance_of_testscript
      config = create_instance_of_config
      func_name_of_make_arg = @ost.make_arg_basename
      Mkspec::Setting.new(testscript, config, func_name_of_make_arg)
    end

    def _create_instance_of_setting
      testscript = create_instance_of_testscript
      config_l = _create_instance_of_config
      func_name_of_make_arg = ost.make_arg_basename
      lt_id = -1
      Mkspec::Setting.new(ost, testscript, config_l, lt_id)
    end

    def create_instance_of_testscript
      name = @ost.start_char
      limit = @ost.limit
      Mkspec::TestScript.new(name, limit)
    end

    def create_instance_of_templatex(config)
      setting = create_instance_of_setting
      Mkspec::Templatex.new(setting, config)
    end

    def _create_instance_of_templatex(config)
      setting = _create_instance_of_setting

      Mkspec::Templatex.new(setting, config)
    end

    def create_instance_of_testgroup_0
      make_arg_basename = @ost.make_arg_basename
      tgroup_0 = @ost.tgroup_0_name
      tgroup = tgroup_0.tr("-", "_").tr(".", "_")
      Mkspec::TestGroup.new(tgroup, make_arg_basename)
    end

    def create_instance_of_testcase
      make_arg_basename = @ost.make_arg_basename
      tgroup_0 = "mruby-MrubyBridge"
      tgroup = tgroup_0.tr("-", "_").tr(".", "_")
      test_group = create_instance_of_testgroup(tgroup, make_arg_basename)
      tcase_0 = "6.2"
      tcase = tcase_0.tr("-", "_").tr(".", "_")
      #args = arg.new()
      #TestCase.new(args)
      #Testcase.new(args)
      #Mkspec::TestCase.new(tcase, test_1, test_1_value, test_1_message, test_1_tag)
      #TestCase.new(tcase, test_1, test_1_value, test_1_message, test_1_tag)
      add_testcases(test_group, 2)
      #Mkspec::TestCase.new(tcase, args.test_1, args.test_1_value, args.test_1_message, args.test_1_tag, args.test_2, args.test_2_value, args.test_2_message, args.test_2_tag, args.extra)
      #Mkspec::TestCase.new(test_group, tcase, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, extra)
    end

    def create_instance_of_testgroup(tgroup, make_arg_basename)
      Mkspec::TestGroup.new(tgroup, make_arg_basename)
    end

    def create_instance_of_testscriptgroup
      fname = @ost.misc_tsv_fname
      start_char = @ost.start_char
      limit = @ost.limit
      make_arg_basename = @ost.make_arg_basename
      Mkspec::TestScriptGroup.new(fname, start_char, limit, make_arg_basename)
    end

    def create_instance_of_mkscript(argv)
      mkscript = Mkspec::Mkscript.new
      mkscript.check_cli_options(argv)
    end
  end
end
