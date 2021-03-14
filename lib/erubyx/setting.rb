# frozen_string_literal: true

module Erubyx
  class Setting
    attr_reader :template_path, :testscript, :make_arg, :data_yaml_path

    def initialize(testscript, config, make_arg)
      puts "Setting.initialize make_arg=#{make_arg}"
      @testscript = testscript
      @hash = {}

      # sub_pn = config.make_path_under_setting_dir(@testscript.name)
      # sub_pn.mkdir unless sub_pn.exist?

      data_sub_pn = config.make_path_under_template_and_data_dir(@testscript.name)
      data_sub_pn.mkdir unless data_sub_pn.exist?
      @template_path = data_sub_pn + 'content.txt'

      @path_value = @template_path.relative_path_from(data_sub_pn.parent)

      @data_yaml_path = data_sub_pn + %(#{@testscript.name}.yml)
      if make_arg == nil || make_arg =~ /^\s*$/
        puts "Setting testscript.name=#{testscript.name}"
        puts "Setting make_arg=|#{make_arg}|"
        raise
      end
      @make_arg = make_arg
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
          make_make_arg(@make_arg)
        rescue => err
          puts "1 test_group.name=#{test_group.name}"
        end
        test_group.test_cases.map do |test_case|
          if test_case.extra
            func_name = test_case.extra
          end
          begin
            make_make_arg(func_name)
          rescue => err
            puts "2 test_group.name=#{test_group.name}"
            puts "2 test_case.name=#{test_case.name}"
          end
            make_context_context(test_case.name, test_group.name, test_case.dir, test_case.test_1, test_case.test_2,
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

    def make_make_arg(func_name, option_list = [])
      raise if name == nil or name =~ /\s*/

      @hash[name] = {
        'path' => 'make_arg/content.txt',
        'func_name' => func_name,
        'option_list' => option_list
      }
    end

    def make_context_context(test_case, test_group, dir, test_1, test_2, func_name)
      @hash[test_case.to_s] = {
        'path' => 'rspec_describe_context_context/content.txt',
        'context' => test_case.to_s,
        'dir' => dir,
        'cdlfile' => %(#{test_group}.cdl),
        'test_1' => test_1,
        'test_2' => test_2,
        'make_arg' => func_name
      }
    end
  end
end
