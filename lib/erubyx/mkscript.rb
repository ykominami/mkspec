# frozen_string_literal: true

module Erubyx
  class Mkscript
    require 'optparse'

    def print_debug
      puts "tsv_fname=#{@tsv_fname}"
      puts "output_dir=#{@output_dir}"
      puts "cmd=#{@cmd}"
    end

    def show_usage_and_exit(opt, message)
      puts message
      puts opt.banner
      exit Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
    end

    def initialize(argv)
      @cmd = 'detect'
      opt = OptionParser.new
      opt.banner = "ruby #{$PROGRAM_NAME} -d dir -t tsv_fname -c (detect|all|partial) -s char -l limit"
      opt.on('-d dir', 'output directory') { |x| @output_dir = x }
      opt.on('-t tsv', 'tsv file') { |x| @tsv_fname = x }
      opt.on('-c cmd', 'command') { |x| @cmd = x }
      opt.on('-s ch', 'start-char') { |x| @start_char = x }
      opt.on('-l limit', 'limit') { |x| @limit = x.to_i }
      opt.parse!(argv)

      show_usage_and_exit(opt, 'A') unless @output_dir
      show_usage_and_exit(opt, 'B') unless @tsv_fname
      show_usage_and_exit(opt, 'C') unless @cmd
      show_usage_and_exit(opt, 'D') unless @start_char
      show_usage_and_exit(opt, 'E') unless @limit

      @make_arg = Erubyx::MAKE_ARG
      puts "mkscript.rb Erubyx::MAKE_ARG=#{Erubyx::MAKE_ARG}"
      puts "mkscript.rb @make_arg=#{@make_arg}"
      @config = Config.new(SPEC_PN,  @output_dir)
      @tsv_path = Pathname.new(@tsv_fname)

      @tsv_path = @config.make_path_under_setting_dir(@tsv_path) unless @tsv_path.exist?

      @tsg = Erubyx::TestScriptGroup.new(@tsv_path, @start_char, @limit, @make_arg)
      @tsg.setup
    end

    def do_process
      case @cmd
      when 'all'
        process_all(@tsg, @config, @make_arg)
      when 'detect'
        process_detect(@tsg, @make_arg)
      else
        process_partial(@tsg, @config, @make_arg)
      end
      true
    end

    def process_detect(_tsg, _make_arg)
      @tsg.testscripts.map do |testscript|
        testscript.test_groups.map do |test_group|
          puts '== test_group'
          puts test_group.name
          puts '  === test_case'
          test_group.test_cases.map do |test_case|
            puts test_case.name
          end
        end
        puts ' ###'
      end
    end

    def process_all(tsg, config, make_arg)
      puts "process_all make_arg=#{make_arg}"
      array = tsg.testscripts.map do |testscript|
        puts "process_all setting make_arg=#{make_arg}"
        setting = Erubyx::Setting.new(testscript, config, make_arg)
        setting.setup('tecsgen command')

        setting.output_data_yamlfile
        templatex = Erubyx::Templatex.new(setting)
        templatex.setup
        templatex.output

        [setting, testscript]
      end
      array.map do |x|
        setting, testscript = x

        data_yaml_path = setting.data_yaml_path
        next unless data_yaml_path.file?

        str = Erubyx::Root.new(data_yaml_path, config).result
        spec_pn = config.make_path_under_script_dir(%(#{testscript.name}_spec.rb))
        spec_pn.parent.mkdir unless spec_pn.parent.exist?
        File.open(spec_pn.to_s, 'w') do |file|
          file.write(str)
        end
      end
    end

    def process_partial(tsg, config, make_arg)
      array = tsg.testscripts.map do |testscript|
        setting = Erubyx::Setting.new(testscript, config, make_arg)
        setting.setup('tecsgen command')
        templatex = nil
        [setting, templatex]
      end
      array.map do |x|
        setting, _tmp = x
        data_yaml_path = setting.data_yaml_path
        Erubyx::Root.new(data_yaml_path, config).result
      end
    end
  end
end
