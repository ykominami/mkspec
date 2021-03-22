# frozen_string_literal: true

module Erubyx
  class Mkscript
    require 'optparse'

    def print_debug
      Loggerxcm.debug_b do
        %W[
          "tsv_fname=#{@tsv_fname}"
          "output_dir=#{@output_dir}"
          "cmd=#{@cmd}"
        ]
      end
      Loggerxcm.debug_b do
        %W[
          "tsv_fname=#{@tsv_fname}",
          "output_dir=#{@output_dir}",
          "cmd=#{@cmd}"
        ]
      end
    end

    def show_usage_and_exit(opt, message)
      Loggerxcm.debug_b do
        %w[
          message
          opt.banner
          Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
        ]
      end
      Loggerxcm.debug_b do
        [
          message,
          opt.banner,
          Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
        ]
      end
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
      init
    end

    def init
      @content_name_of_make_arg = Erubyx::MAKE_ARG
      @config = Config.new(SPEC_PN, @output_dir).setup
      @tsv_path = Pathname.new(@tsv_fname)
      @tsv_path = @config.make_path_under_misc_dir(@tsv_path) unless @tsv_path.exist?

      @tsg = Erubyx::TestScriptGroup.new(@tsv_path, @start_char, @limit, @content_name_of_make_arg).setup
      func_name_of_make_arg = MAKE_ARG
      @setting_and_testscript_array = make_array_of_setting_and_testscript(@tsg, @config, func_name_of_make_arg)
    end

    def make_array_of_setting_and_testscript(tsg, config, func_name_of_make_arg)
      tsg.testscripts.map do |testscript|
        setting = create_setting_instance(testscript, config, func_name_of_make_arg)
        [setting, testscript]
      end
    end

    def create_setting_instance(testscript, config, func_name_of_make_arg)
      setting = Erubyx::Setting.new(testscript, config, func_name_of_make_arg)
      setting.setup('tecsgen command')
      setting
    end

    def create_files
      case @cmd
      when 'all'
        create_all_template_and_data_and_spec_file(:CREATE, @config)
      else
        create_all_template_and_data_and_spec_file(:NOT_CREATE, @config)
      end
      true
    end

    def create_all_template_and_data_and_spec_file(cmd, config)
      # puts "process_from_template func_name_make_arg=#{func_name_of_make_arg}"
      create_all_template_and_data(@setting_and_testscript_array) if cmd == :CREATE
      create_all_spec_file(config, @setting_and_testscript_array)
    end

    def create_all_template_and_data(array)
      array.map do |x|
        setting, _tmp = x
        make_template_and_data(setting)
      end
    end

    def make_template_and_data(setting)
      setting.output_data_yamlfile
      make_template(setting)
    end

    def make_template(setting)
      templatex = Erubyx::Templatex.new(setting)
      templatex.setup
      templatex.output
    end

    def create_all_spec_file(config, array)
      array.map do |x|
        setting, testscript = x
        make_spec_file(config, setting, testscript)
      end
    end

    def make_spec_file(config, setting, testscript)
      data_yaml_path = setting.data_yaml_path
      return unless data_yaml_path.file?

      str = Erubyx::Root.new(data_yaml_path, config).result
      spec_file_pn = config.make_path_under_script_dir(%(#{testscript.name}_spec.rb))
      spec_file_pn.parent.mkdir unless spec_file_pn.parent.exist?

      begin
        str_2 = Mkscript.format(str)
      rescue StandardError => e
        Loggerxcm.error_b { e.to_s }
        Loggerxcm.error("Can't convert for #{spec_file_pn}")
        str_2 = str
      end

      File.open(spec_file_pn.to_s, 'w') { |file| file.write(str_2) }
    end

    def self.format(code)
      Rufo::Formatter.format(code, {})
    end
  end
end
