# frozen_string_literal: true

module TestConf
  require "pathname"
  require "ostruct"
  require "clitest"

  class TestConf
    attr_reader :o

    def initialize(global_yaml, target_cmd_1, target_cmd_2, original_spec_file_path)

      setup(o)
    end

    def setup(o)
      o._output_dir_pn = o.test_root_dir_pn.join("_output")
      o._output_dir = o._output_dir_pn.to_s
      o._test_case_dir_pn = o._output_dir_pn.join("test_case")
      o._test_case_dir = o._test_case_dir_pn.to_s
      o._template_and_data_dir_pn = o._output_dir_pn.join("template_and_data")
      o._template_and_data_dir = o._template_and_data_dir_pn.to_s
      o._script_dir_pn = o._output_dir_pn.join("script")
      o._script_dir = o._script_dir_pn.to_s
      o._yaml_fname = "a.yml"
      o._data_dir_pn = o._template_and_data_dir_pn.join("a")
      #
      o.data_dir_pn = o.output_template_and_data_dir_pn.join("a")
      o.tad_2_dir = "template_and_data_2"
      o.script_3_dir = "script_3"
      #
      o.start_char = "a"
      o.limit = 6
      o.test_1 = "test_1"
      o.test_2 = "test_2"
      o.format_fname = "format.txt"
      o.number_of_testgroup = 59
      o.number_of_testscript = 19
      o.number_of_testgroup_of_first_testscript = 3
      o.tgroup_0_name = "mruby-MrubyBridge"
      o.tgroup_0_name_normalize = "mruby_MrubyBridge"
      o.cmdline_0 = Clitest::Cmdline.new(nil, nil, o.target_parent_dir_pn, o.target_cmd_1_pn)
      #
      @global_hash.map { |x| o[x[0]] = x[1] if o[x[0]] == nil || o[x[0]] =~ /^\s*$/ }
      #
      @o = o
    end

    def method_missing(name, arg)
      case name
      when :_config
        p "method_missing _config"
        @o._config = Mkspec::Config.new(@o.spec_dir, @o._output_dir, nil, nil).setup
      when :config_0
        p "method_missing config_0"
        @o.config_0 = Mkspec::Config.new(@o.spec_dir, @o.output_dir, nil, nil).setup
      else
        p "method_missing name=#{name} name.class=#{name.class} nil"
        nil
      end
    end

    def get_path(parent_dir_pn, dir, cmd_1, cmd_2)
      pn_0 = parent_dir_pn.join(dir)
      if pn_0.exist?
        dir_pn = pn_0.realpath

        if cmd_1
          pn_1 = dir_pn.join(cmd_1)
          pn_cmd_1 = pn_1.exist? ? pn_1 : nil
        else
          pn_cmd_1 = nil
        end

        if cmd_2
          pn_2 = dir_pn.join(cmd_2)
          pn_cmd_2 = pn_2.exist? ? pn_2 : nil
        else
          pn_cmd_2 = nil
        end
        [dir_pn, pn_cmd_1, pn_cmd_2]
      else
        [nil, nil, nil]
      end
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
      Mkspec::Config.new(@o.spec_dir, @o.output_dir, nil, nil).setup
    end

    def _create_instance_of_config
      Mkspec::Config.new(@o.spec_dir, @o._output_dir, nil, nil).setup
    end

    def create_instance_of_root
      yml_path = @o.config_0.make_path_under_template_and_data_dir(Pathname.new("a").join(@o.yaml_fname))
      Mkspec::Root.new(yml_path, @o.config_0)
    end

    def _create_instance_of_root
      _config(nil)
      yml_path = @o._config.make_path_under_template_and_data_dir(Pathname.new("a").join(@o.yaml_fname))
      Mkspec::Root.new(yml_path, @o._config)
    end

    def create_instance_of_item(content_path, yaml_path)
      level = 1
      tag = "make_arg_data_flat"
      hash = {}
      #              (size,  name, outer_hash,   content_path, yaml_path, config)
      @o._config.setup
      Mkspec::Item.new(level, 0, tag, hash, content_path, yaml_path, @o._config)
    end

    def _create_instance_of_item(content_path, yaml_path)
      level = 1
      tag = "make_arg_data_flat"
      hash = {}
      #              (size,  name, outer_hash,   content_path, yaml_path, config)
      _config(nil)
      @o._config.setup
      Mkspec::Item.new(level, 0, tag, hash, content_path, yaml_path, @o._config)
    end

    def create_instance_of_setting
      testscript = create_instance_of_testscript
      config = create_instance_of_config
      func_name_of_make_arg = o.make_arg_basename
      Mkspec::Setting.new(testscript, config, func_name_of_make_arg)
    end

    def _create_instance_of_setting
      testscript = create_instance_of_testscript
      _config = _create_instance_of_config
      func_name_of_make_arg = o.make_arg_basename
      lt_id = -1
      Mkspec::Setting.new(@global_hash, testscript, _config, lt_id)
    end

    def create_instance_of_testscript
      name = o.start_char
      limit = o.limit
      Mkspec::TestScript.new(name, limit)
    end

    def create_instance_of_templatex
      setting = create_instance_of_setting
      Mkspec::Templatex.new(setting)
    end

    def _create_instance_of_templatex
      setting = _create_instance_of_setting
      Mkspec::Templatex.new(setting)
    end

    def create_instance_of_testgroup_0
      make_arg_basename = o.make_arg_basename
      tgroup_0 = o.tgroup_0_name
      tgroup = tgroup_0.tr("-", "_").tr(".", "_")
      Mkspec::TestGroup.new(tgroup, make_arg_basename)
    end

    def create_instance_of_testcase
      make_arg_basename = o.make_arg_basename
      tgroup_0 = "mruby-MrubyBridge"
      tgroup = tgroup_0.tr("-", "_").tr(".", "_")
      test_group = create_instance_of_testgroup(tgroup, make_arg_basename)
      tcase_0 = "6.2"
      tcase = tcase_0.tr("-", "_").tr(".", "_")
      test_1 = nil
      test_1_value = nil
      test_2 = nil
      test_2_value = nil
      extra = nil
      Mkspec::TestCase.new(test_group, tcase, test_1, test_1_value, test_2, test_2_value, extra)
    end

    def create_instance_of_testgroup(tgroup, make_arg_basename)
      Mkspec::TestGroup.new(tgroup, make_arg_basename)
    end

    def create_instance_of_testscript
      name = o.start_char
      limit = o.limit
      Mkspec::TestScript.new(name, limit)
    end

    def create_instance_of_testscriptgroup
      fname = @o.misc_tsv_fname
      start_char = o.start_char
      limit = o.limit
      make_arg_basename = o.make_arg_basename
      Mkspec::TestScriptGroup.new(fname, start_char, limit, make_arg_basename)
    end

    def create_instance_of_testscript
      name = o.start_char
      limit = o.limit
      Mkspec::TestScript.new(name, limit)
    end

    def create_instance_of_mkscript(argv)
      Mkspec::Mkscript.new(argv)
    end
  end
end