# frozen_string_literal: true

require 'pp'

module Erubyx
  class Setting
    attr_reader :template_path, :testscript, :data_yaml_path, :func_name_of_make_arg

    def initialize(testscript, config, func_name_of_make_arg)
      Loggerxcm.debug("Setting.initialize func_name_of_make_arg=#{func_name_of_make_arg}")
      @testscript = testscript
      @hash = {}
      name = @testscript.name
      raise unless name.instance_of?(String)
      data_sub_pn = config.make_path_under_template_and_data_dir(name)
      data_sub_pn.mkdir unless data_sub_pn.exist?
      @template_path = data_sub_pn.join('content.txt')

      @path_value = @template_path.relative_path_from(data_sub_pn.parent)
      name_2 = @testscript.name
      raise unless name_2.instance_of?(String)
      @data_yaml_path = data_sub_pn.join(%(#{name_2}.yml))
      if func_name_of_make_arg.nil? || func_name_of_make_arg =~ /^\s*$/
        Loggerxcm.debug("Setting testscript.name=#{name_2}")
        Loggerxcm.debug("Setting func_name_of_make_arg=|#{func_name_of_make_arg}|")
        raise
      end
      @func_name_of_make_arg = func_name_of_make_arg
    end

    def setup(desc)
      @hash['path'] = @path_value.to_s
      @hash['desc'] = desc
      @hash['rspec_describe_head'] = { 'path' => 'rspec_describe_head/content.txt' }
      @hash['rspec_describe_end'] = { 'path' => 'rspec_describe_end/content.txt' }
      @hash['rspec_describe_context_end'] = { 'path' => 'rspec_describe_context_end/content.txt' }
      error_count = 0
      @testscript.test_groups.map do |test_group|
        name = test_group.name
        raise unless name.instance_of?(String)
        make_context(name)
        ret = make_make_arg(test_group.content_name_of_make_arg, @func_name_of_make_arg)
        ret = setup_test_cases(test_group) if ret
        error_count += 1 unless ret
      end
      error_count.zero?
    end

    def setup_test_cases(test_group)
      test_group_name = test_group.name
      raise unless test_group_name.instance_of?(String)
      error_count = 0
      test_group.test_cases.map do |test_case|
        func_name = @func_name_of_make_arg
        func_name = test_case.extra if test_case.extra
        ret = make_make_arg(test_group.content_name_of_make_arg, func_name)
        if ret
          make_context_context(test_case.name, test_group.name, test_case.dir,
                               test_case.test_1, test_case.test_1_value,
                               test_case.test_2, test_case.test_2_value,
                               func_name)
        end
        error_count += 1 unless ret
      end
      error_count.zero?
    end

    def output_data_yamlfile
      ret = true
      begin
        File.open(@data_yaml_path, 'w') { |file| file.write(YAML.dump(@hash)) }
      rescue StandardError => e
        Loggerxcm.error_b do
          %w[
            e.to_s
            e.backtrace
          ]
        end
        ret = false
      end
      ret
    end

    def make_context(test_group_name)
      raise unless test_group_name.instance_of?(String)
      raise if @hash[test_group_name]
      @hash[test_group_name] = {
        'path' => 'rspec_describe_context/content.txt',
        'context' => test_group_name
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
        'path' => 'make_arg/content.txt',
        'func_name' => func_name,
        'option_list' => option_list
      }
      ret
    end

    def make_context_context(test_case_name, test_group, dir, test_1, test_1_value, test_2, test_2_value, func_name)
      raise unless test_case_name.instance_of?(String)
      @hash[test_case_name] = {
        'path' => 'rspec_describe_context_context/content.txt',
        'context' => test_case_name,
        'dir' => dir,
        'cdlfile' => %(#{test_group}.cdl),
        'test_1' => test_1,
        'test_1_value' => test_1_value,
        'test_2' => test_2,
        'test_2_value' => test_2_value,
        'func_name' => func_name
      }
    end
  end
end
