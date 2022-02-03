# frozen_string_literal: true


module Mkspec

  class Setting
    attr_reader :template_path, :testscript, :data_yaml_path, :func_name_of_make_arg
    attr_reader :lt_id

    def initialize(global_config, testscript, config, initail_testcase_id)
      raise(Mkspec::MkspecAppError, "setting.rb 1 #{STATE.message}") unless global_config
      @gc = global_config
      Loggerxcm.debug("Setting.initialize make_arg=#{@gc.make_arg}")
      @testscript = testscript
      @hash = {}
      name = @testscript.name
      raise(MkspecAppError,  "setting.rb 2 #{STATE.message}") unless Util.not_empty_string?(name).first
      data_sub_pn = config.make_path_under_template_and_data_dir(name)
      data_sub_pn.mkdir unless data_sub_pn.exist?
      @template_path = data_sub_pn.join("content.txt")

      @path_value = @template_path.relative_path_from(data_sub_pn.parent)
      name_2 = @testscript.name
      raise(MkspecAppError, "setting.rb 3  #{STATE.message}") unless Util.not_empty_string?(name_2).first
      @data_yaml_path = data_sub_pn.join(%(#{name_2}.yml))
      if @gc.make_arg.nil? || @gc.make_arg =~ /^\s*$/
        Loggerxcm.debug("Setting testscript.name=#{name_2}")
        Loggerxcm.debug("Setting make_arg=|#{@gc.make_arg}|")
        raise(MkspecAppError, "setting.rb 4  Can not get make_arg")
      end
      @func_name_of_make_arg = @gc.make_arg

      @lt_id = initail_testcase_id
    end

    def next_testcase_id
      @lt_id += 1
    end

    def setup(desc)
      @hash["path"] = @path_value.to_s
      @hash["desc"] = desc
      raise(MkspecAppError, "setting.rb X") unless Util.not_empty_string?(@gc.top_dir).first

      @hash["rspec_describe_head"] = {
        "path" => "rspec_describe_head/content.txt",
        @gc.get_key_of_top_dir => @gc.top_dir.to_s,
        @gc.get_key_of_original_output_dir => @gc.output_dir,
        @gc.get_key_of_target_cmd_1 => @gc.target_cmd_1,
        @gc.get_key_of_target_cmd_2 => @gc.target_cmd_2,
        @gc.get_key_of_tecspath => @gc.tecspath,
        @gc.get_key_of_tecspath_cmd_path => @gc.tecsgen_cmd_path,
        @gc.get_key_of_global_yaml_fname => @gc.global_yaml_fname,
        @gc.get_key_of_test_case_dir => @gc.test_case_dir,
      }
      @hash["rspec_describe_end"] = { "path" => "rspec_describe_end/content.txt" }
      @hash["rspec_describe_context_end"] = { "path" => "rspec_describe_context_end/content.txt" }
      error_count = 0
      @testscript.test_groups.map do |test_group|
        name = test_group.name
        raise(MkspecAppError, "setting.rb 5  #{STATE.message}") unless Util.not_empty_string?(name).first
        make_context(name)
        ret = make_make_arg(test_group.content_name_of_make_arg, @func_name_of_make_arg)
        ret = setup_test_cases(test_group) if ret
        error_count += 1 unless ret
      end
      error_count.zero?
    end

    def setup_test_cases(test_group)
      test_group_name = test_group.name
      raise(MkspecAppError, "setting.rb 6  #{STATE.message}") unless Util.not_empty_string?(test_group_name).first
      error_count = 0
      test_group.test_cases.map do |test_case|
        func_name = @func_name_of_make_arg
        func_name = test_case.extra if test_case.extra
        ret = make_make_arg(test_group.content_name_of_make_arg, func_name)
        if ret
          raise(MkspecDebugError, "setting.rb 7  #{STATE.message}") if Util.numeric?(test_case.test_1)
          make_context_context(test_case.name, test_group.name, test_case.dir,
                               test_case.test_1, test_case.test_1_value, test_case.test_1_message, test_case.test_1_tag,
                               test_case.test_2, test_case.test_2_value, test_case.test_2_message, test_case.test_2_tag,
                               func_name)
        end
        error_count += 1 unless ret
      end
      error_count.zero?
    end

    def output_data_yamlfile
      ret = true
      begin
        File.open(@data_yaml_path, "w") { |file| file.write(YAML.dump(@hash)) }
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace,
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_WRITE_YAML_FILE)
        ret = false
      end
      raise(Mkspec::MkspecDebugError, "setting.rb 8  #{STATE.message}") unless STATE.success?
      ret
    end

    def make_context(test_group_name)
      raise(MkspecAppError, "setting.rb 9") unless Util.not_empty_string?(test_group_name).first
      raise(MkspecAppError, "setting.rb 10") if @hash[test_group_name]
      @hash[test_group_name] = {
        "path" => "rspec_describe_context/content.txt",
        "context" => test_group_name,
        "tecsgen_cmd" => @gc.tecsgen_cmd
      }
    end

    def make_make_arg(content_name, func_name, option_list = [])
      ret = true
      if content_name.nil? || content_name =~ /^\s*$/
        Loggerxcm.debug "make_make_arg content_name=#{content_name}|"
        ret = false
      end

      if func_name.nil? || func_name =~ /^\s*$/
        Loggerxcm.debug "make_make_arg func_name=#{func_name}|"
        ret = false
      end

      @hash[content_name] = {
        "path" => "make_arg/content.txt",
        "func_name" => func_name,
        "option_list" => option_list,
      }
      ret
    end

    def make_context_context(test_case_name, test_group, dir, test_1, test_1_value, test_1_message, test_1_tag, test_2, test_2_value, test_2_message, test_2_tag, func_name)
      raise(MkspecAppError, "setting.rb 11") unless Util.not_empty_string?(test_case_name).first
      tc_0 = next_testcase_id
      tc_1 = next_testcase_id
      @hash[test_case_name] = {
        "path" => "rspec_describe_context_context/content.txt",
        "context" => test_case_name,
        "dir" => dir,
        "cdlfile" => %(#{test_group}.cdl),
        "test_1" => test_1,
        "test_1_value" => test_1_value,
        "test_1_message" => test_1_message,
        "test_1_tag" => test_1_tag,
        "test_2" => test_2,
        "test_2_value" => test_2_value,
        "test_2_message" => test_2_message,
        "test_2_tag" => test_2_tag,
        "func_name" => func_name,
        "tc_0" => tc_0,
        "tc_1" => tc_1,
      }
    end
  end
end
