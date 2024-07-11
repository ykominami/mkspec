# frozen_string_literal: true

module Mkspec
  require "pathname"
  require "ostruct"
  require "clitest"

  class TestConf
    attr_reader :ost

    def initialize(top_dir_yaml, resolved_top_dir_yaml, specific_yaml, global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path)
      invalid_count = 0
      place = "TestConf.initialize"
      invalid_count += Util.validate_filex(place, top_dir_yaml, "top_dir_yaml")
      invalid_count += Util.validate_filex(place, resolved_top_dir_yaml, "resolved_top_dir_yaml")
      invalid_count += Util.validate_filex(place, specific_yaml, "specific_yaml")
      invalid_count += Util.validate_filex(place, global_yaml, "global_yaml")
      return if invalid_count.positive?

      @top_dir_hash = Util.make_hash_from_files(top_dir_yaml, resolved_top_dir_yaml)
      @globalconfig = Mkspec::GlobalConfig.new(false, @top_dir_hash, specific_yaml.pathname, global_yaml.pathname, target_cmd_1, target_cmd_2, original_spec_file_path)
      @ost = @globalconfig.ost

      invalid_count += Util.validate_path(place, @ost.data_top_dir, "@ost.data_top_dir")
      invalid_count += Util.validate_path(place, @ost.output_data_top_dir, "@ost.output_data_top_dir")
      invalid_count += Util.validate_path(place, @ost.output_dir, "@ost.output_dir")
      return if invalid_count.positive?

      setup(@ost)

      invalid_count += Util.validate_path(place, @ost.data_top_dir, "@ost.data_top_dir")
      invalid_count += Util.validate_path(place, @ost.output_data_top_dir, "@ost.output_data_top_dir")
      invalid_count += Util.validate_path(place, @ost.output_dir, "@ost.output_dir")

      @invalid_count = invalid_count
    end

    def make_hash_from(top_dir_yaml_filex, _)
      # ignore resolved_top_dir_yaml_filex
      # top_dir_hash = {}
      place = "TestConf#make_hash_from"
      ret = Utile.validate_filex(place, top_dir_yaml_filex, "top_dir_yaml_filex")
      return if ret.positive?

      pn = top_dir_yaml_filex.pathname
      ret = Utile.validate_pathname(place, pn, "pn")
      return if ret.positive?

      @top_dir_hash = Util.extract_in_yaml_file(pn, {})
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
      return false if ost.output_data_top_dir.nil?

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
      ost.cmdline_0 = Clitest::Cmdline.new(nil, nil, ost.target_parent_dir_pn, [ost.target_cmd_1_pn, ost.target_cmd_2_pn])
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
      @ost._mkscript.init_sub(@globalconfig, @ost._config, @globalconfig.tsv_path, @ost.tad_dir, @ost.start_char, @ost.limit, @globalconfig.make_arg, cmd)
      @ost._mkscript.create_files
    end

    def mkscript_0
      config_0
      @ost.mkscript_0 = Mkspec::Mkscript.new
      @ost.mkscript_0.init_sub(@ost._config, @globalconfig.tsv_path, @ost.tad_dir, @ost.start_char, @ost.limit, @globalconfig.make_arg)
    end

    def _config
      @ost._config = Mkspec::Config.new(@ost.data_top_dir, @ost._output_data_top_dir, @ost._output_dir,
                                        @ost.output_script_dir_pn, @ost.output_template_and_data_dir).setup
    end

    def config_0
      @ost.config_0 = Mkspec::Config.new(@ost.data_top_dir, @ost._output_data_top_dir, @ost.output_dir,
                                         @ost.output_script_dir_pn, @ost.output_template_and_data_dir).setup
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
      return false if @ost.spec_dir
      return false if @ost.data_top_dir
      return false if @ost.output_data_top_dir
      return false if @ost.output_dir

      Mkspec::Config.new(@ost.data_top_dir, @ost.output_data_top_dir, @ost.output_dir, nil, nil).setup
    end

    def _create_instance_of_config
      if @ost.spec_dir.nil?
        Loggerxcm.debug("TestConf#_create_instance_of_config @ost.spec_dir=nil")
        return nil
      end
      if @ost.data_top_dir.nil?
        Loggerxcm.debug("TestConf#_create_instance_of_config @ost.data_top_dir=nil")
        return nil
      end
      if @ost.output_data_top_dir.nil?
        Loggerxcm.debug("TestConf#_create_instance_of_config @ost.output_data_top_dir=nil")
        return nil
      end
      if @ost._output_dir.nil?
        Loggerxcm.debug("TestConf#_create_instance_of_config @ost._output_dir=nil")
        return nil
      end
      Mkspec::Config.new(@ost.data_top_dir, @ost.output_data_top_dir, @ost._output_dir, @ost.output_script_dir, nil).setup
    end

    def create_instance_of_root
      yml_path = Pathname.new("a").join(@ost.yaml_fname).to_s
      Mkspec::Root.new(yml_path, @ost.config_0)
    end

    def _create_instance_of_root
      place = "TestConf#_create_instance_of_root"
      _mkscript
      #      yml_path = @ost._config.make_path_under_template_and_data_dir(Pathname.new("a").join(@ost.yaml_fname))
      Loggerxcm.debug("TestConf#_create_instance_of_root @ost.yaml_fname=#{@ost.yaml_fname}")
      ret = Util.not_empty_string?(@ost.yaml_fname)
      if ret == false
        Loggerxcm.debug("TestConf#_create_instance_of_root 1")
        return nil
      end
      result = Util.check_var(place, @ost._config, "@ost._config")
      if result.positive?
        conf = @ost.config
        yml_path = conf.make_path_under_template_and_data_dir("a").join("a.yml").to_s
      else
        yml_path = @ost._config.make_path_under_template_and_data_dir("a").join("a.yml").to_s
      end
      # yml_path = Pathname.new("a").join(@ost.yaml_fname).to_s
      Util.dump_var(:yml_path, "#{yml_path}|")
      # binding.break
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
      # tcase_0 = "6.2"
      # tcase = tcase_0.tr("-", "_").tr(".", "_")
      add_testcases(test_group, 2)
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
