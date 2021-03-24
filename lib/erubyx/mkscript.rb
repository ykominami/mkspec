# frozen_string_literal: true

module Erubyx
  class Mkscript
    require 'optparse'

    def initialize(argv)
      check_cli_options(argv)
      init
    end

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

    def check_cli_options(argv)
      command_options = %w[ spec tad all ]
      command_options_str = command_options.join(' ')
      opt = OptionParser.new
      opt.banner = "ruby #{$PROGRAM_NAME} -o output_dir -d script_dir -i tad_dir -t tsv_fname -c (all|tad|scr) -s char -l limit"
      opt.on('-o output_dir', 'output directory') { |x| @output_dir = x }
      opt.on('-d script_dir', 'script directory') { |x| @script_dir = x }
      opt.on('-i tad_dir', 'limit') { |x| @tad_dir = x }
      opt.on('-t tsv', 'tsv file') { |x| @tsv_fname = x }
      opt.on('-c cmd', 'command') { |x| @cmd = x }
      opt.on('-s ch', 'start-char') { |x| @start_char = x }
      opt.on('-l limit', 'limit') { |x| @limit = x.to_i }
      opt.parse!(argv)

      show_usage_and_exit(opt, 'c') unless command_options.find { |it| @cmd == it }
      show_usage_and_exit(opt, 'o') unless @output_dir
#      show_usage_and_exit(opt, 'd') unless @script_dir
#      show_usage_and_exit(opt, 'i') unless @tad_dir
      show_usage_and_exit(opt, 't') unless @tsv_fname
      show_usage_and_exit(opt, 'c') unless @cmd
      show_usage_and_exit(opt, 's') unless @start_char
      show_usage_and_exit(opt, 'l') unless @limit
    end

    def init
      @content_name_of_make_arg = Erubyx::MAKE_ARG
      @config = Config.new(SPEC_PN, @output_dir, @script_dir, @tad_dir).setup
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

    def show_usage_and_exit(opt, message = nil)
      Loggerxcm.error_b do
        %w[
          message
          opt.banner
        ]
      end
      exit(Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR)
    end

    def create_files
      case @cmd
      when 'all'
        template_and_data = true
        script = true
      when 'tad'
        template_and_data = true
      else
        # scr
        script = true
      end
      ret = true
      ret = create_all_template_and_data(@setting_and_testscript_array) if template_and_data && ret
      ret = create_all_spec_file(@config, @setting_and_testscript_array) if script && ret

      ret
    end

    def create_all_template_and_data(array)
      error_count = 0
      array.map do |x|
        setting, _tmp = x
        ret = make_template_and_data(setting)
        error_count += 1 unless ret
      end
      error_count.zero?
    end

    def make_template_and_data(setting)
      setting.output_data_yamlfile
      make_template(setting)
    end

    def make_template(setting)
      templatex = Erubyx::Templatex.new(setting)
      ret = templatex.setup
      templatex.output if ret
    end

    def create_all_spec_file(config, array)
      error_count = 0
      array.map do |x|
        setting, testscript = x
        ret = make_spec_file(config, setting, testscript)
        error_count += 1 unless ret
      end
      error_count.zero?
    end

    def make_spec_file(config, setting, testscript)
      ret = true
      data_yaml_path = setting.data_yaml_path
      return unless data_yaml_path.file?

      str = Erubyx::Root.new(data_yaml_path, config).result
      spec_fname = Util.make_spec_filename(testscript.name)
      spec_file_pn = config.make_path_under_script_dir(spec_fname)
      spec_file_pn.parent.mkdir unless spec_file_pn.parent.exist?

      begin
        str_2 = Mkscript.format(str)
      rescue StandardError => e
        Loggerxcm.error_b { e.to_s }
        Loggerxcm.error("Can't convert for #{spec_file_pn}")
        str_2 = str
      end

      begin
        File.open(spec_file_pn.to_s, 'w') { |file| file.write(str_2) }
      rescue StandardError => e
        Loggerxcm.error_b { e.to_s }
        Loggerxcm.error("Can't convert for #{spec_file_pn}")
        str_2 = str
        ret = false
      end
      ret
    end

    def self.format(code)
      Rufo::Formatter.format(code, {})
    end

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
          "tsv_fname=#{@tsv_fname}"
          "output_dir=#{@output_dir}"
          "cmd=#{@cmd}"
        ]
      end
    end
  end
end
