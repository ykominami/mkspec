module Erubyx
  class Setting
    attr_reader :path, :output_path, :testscript, :make_arg, :yaml_path

    def initialize(testscript, data_top_dir, make_arg)
      @testscript = testscript
      @hash = {}
      sub_pn = Pathname.new(@testscript.name)
      @path = sub_pn + 'content.txt'
      pn = Pathname.new(data_top_dir)
      @output_path = pn + @path
      @yaml_path = pn + %(#{@testscript.name}.yml)
      @make_arg = make_arg
    end

    def setup
      @hash['path'] = @path.to_s
      @hash['desc'] = 'tecsgen command'
      @hash['rspec_describe_head'] = { 'path' => 'rspec_describe_head/content.txt' }
      @hash['rspec_describe_end'] = { 'path' => 'rspec_describe_end/content.txt' }
      @hash['rspec_describe_context_end'] = { 'path' => 'rspec_describe_context_end/content.txt' }
      @testscript.test_groups.map do |test_group|
        make_context(test_group.name)
        make_make_arg(@make_arg)
        test_group.test_cases.map do |test_case|
          if test_case.extra
            func_name = test_case.extra
            make_make_arg(test_case.extra)
          end
          make_context_context(test_case.name, test_group.name, test_case.dir, test_case.test_1, test_case.test_2,
                               func_name)
        end
      end
    end

    def output_yaml
      File.open(@yaml_path, 'w') do |file|
        file.write(YAML.dump(@hash))
      end
    end

    def make_context(test_group)
      @hash[test_group] = {
        'path' => 'rspec_describe_context/content.txt',
        'context' => test_group.to_s
      }
    end

    def make_make_arg(name, option_list = [])
      @hash[name] = {
        'path' => 'make_arg/content.txt',
        'func_name' => name,
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
