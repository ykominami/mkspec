# frozen_string_literal: true
require 'pp'

module Erubyx
  class Setting
    attr_reader :template_path, :testscript, :data_yaml_path, :func_name_of_make_arg

    def initialize(testscript, config, func_name_of_make_arg)

      Loggerxcm.debug( "Setting.initialize func_name_of_make_arg=#{func_name_of_make_arg}" )
      @testscript = testscript
      @hash = {}

      data_sub_pn = config.make_path_under_template_and_data_dir(@testscript.name)
      data_sub_pn.mkdir unless data_sub_pn.exist?
      @template_path = data_sub_pn + 'content.txt'

      @path_value = @template_path.relative_path_from(data_sub_pn.parent)

      @data_yaml_path = data_sub_pn + %(#{@testscript.name}.yml)
      if func_name_of_make_arg == nil || func_name_of_make_arg =~ /^\s*$/
        Loggerxcm.debug("Setting testscript.name=#{testscript.name}")
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
      @testscript.test_groups.map do |test_group|
        make_context(test_group.name)
        begin
          make_make_arg(test_group.content_name_of_make_arg, @func_name_of_make_arg)
        rescue => err
          Loggerxcm.debug_b{
            ["1 test_group.name=#{test_group.name}",
            err.to_s,
            "1 Fail make_make_arg",
            "test_group.content_name_of_make_arg=#{test_group.content_name_of_make_arg}",
            "@func_name_of_make_arg=#{@func_name_of_make_arg}"]
          }
          exit 100
        end
        test_group.test_cases.map do |test_case|
          func_name = @func_name_of_make_arg
          if test_case.extra
            func_name = test_case.extra
          end
          begin
            make_make_arg(test_group.content_name_of_make_arg, func_name)
          rescue => err
            Loggerxcm.debug_b {
              ["2 test_group.name=#{test_group.name}",
              "2 test_case.name=#{test_case.name}",
              err.to_s,
              "2 test_group.content_name_of_make_arg=#{test_group.content_name_of_make_arg}",
              "2 Fail make_make_arg"]
             }
            exit 200
          end
            make_context_context(test_case.name, test_group.name, test_case.dir, 
                                  test_case.test_1, test_case.test_1_value, 
                                  test_case.test_2, test_case.test_2_value, 
                                  func_name)
        end
      end
    end

    def output_data_yamlfile
      File.open(@data_yaml_path, 'w') do |file|
        file.write(YAML.dump(@hash))
      end
    end

    def make_context(test_group)
      @hash[test_group] = {
        'path' => 'rspec_describe_context/content.txt',
        'context' => test_group.to_s
      }
    end

    def make_make_arg(content_name, func_name, option_list = [])
      if func_name == nil or func_name =~ /^\s*$/
        Loggerxcm.debug "make_make_arg func_name=#{func_name}|"
        raise
      end
      @hash[content_name] = {
        'path' => 'make_arg/content.txt',
        'func_name' => func_name,
        'option_list' => option_list
      }
    end

    def make_context_context(test_case, test_group, dir, test_1, test_1_value, test_2, test_2_value, func_name)
      @hash[test_case.to_s] = {
        'path' => 'rspec_describe_context_context/content.txt',
        'context' => test_case.to_s,
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
