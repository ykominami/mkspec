# frozen_string_literal: true

module Mkspec
  class Mkscript
    require "optparse"

    def initialize(argv)
      #p "Mkscript.new = argv=#{argv}"
      check_cli_options(argv)
      init if STATE.success?
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

    def check_cli_options(argv)
      command_options = %w[ spec tad all ]
      command_options_str = command_options.join(" ")
      opt = OptionParser.new
      #
      STATE.opt = opt
      #
      opt.banner = "ruby #{$PROGRAM_NAME} -o output_dir -d script_dir -i tad_dir -t tsv_fname -c (all|tad|scr) -s char -l limit -x original_output_dir -y target_cmd_1_pn -z target_cmd_1_pn"
      opt.on("-o output_dir", "output directory") { |x| @output_dir = x }
      opt.on("-d script_dir", "script directory") { |x| @script_dir = x }
      opt.on("-i tad_dir", "limit") { |x| @tad_dir = x }
      opt.on("-t tsv", "tsv file") { |x| @tsv_fname = x }
      opt.on("-c cmd", "command") { |x| @cmd = x }
      opt.on("-s ch", "start-char") { |x| @start_char = x }
      opt.on("-l limit", "limit") { |x| @limit = x.to_i }
      opt.on("-g global_yaml", "global yamlfile") { |x| @global_yaml_fname = x }
      opt.on("-x original_output_dir", "original output dir") { |x| @original_output_dir = x }
      opt.on("-y target_cmd1", "path of target command 1") { |x| @target_cmd1 = x }
      opt.on("-z target_cmd1", "path of target command 2") { |x| @target_cmd2 = x }
      begin
        opt.parse!(argv)
      rescue => e
        message = %W[#{e.message} #{e.backtrace}]
        Loggerxcm.error_b do
          #{message}
        end
        return STATE.change(CMDLINE_OPTION_ERROR, message)
      end

      return STATE.change(CMDLINE_OPTION_ERROR_O, "not specified -o") unless @output_dir
      return STATE.change(CMDLINE_OPTION_ERROR_T, "not specified -t") unless @tsv_fname
      return STATE.change(CMDLINE_OPTION_ERROR_C, "not specified -c") unless @cmd
      return STATE.change(CMDLINE_OPTION_ERROR_C, "invalid -c") unless command_options.find { |it| @cmd == it }
      return STATE.change(CMDLINE_OPTION_ERROR_S, "not specified -s") unless @start_char
      return STATE.change(CMDLINE_OPTION_ERROR_L, "not specified -l") unless @limit
      return STATE.change(CMDLINE_OPTION_ERROR_G, "not specified -g") unless @global_yaml_fname
      @global_yaml_pn = Pathname.new(@global_yaml_fname)
      return STATE.change(CMDLINE_OPTION_ERROR_G, "invalid -g") unless @global_yaml_pn.exist?
      return STATE.change(CMDLINE_OPTION_ERROR_X, "not specified -x") unless @original_output_dir
      return STATE.change(CMDLINE_OPTION_ERROR_Y, "not specified -y") unless @target_cmd1
      return STATE.change(CMDLINE_OPTION_ERROR_Z, "not specified -z") unless @target_cmd2
    end

    def init
      @latest_testcase_id = -1

      @global_hash = Mkspec::Util.extract_yaml(@global_yaml_pn)
      @global_hash[GLOBAL_YAML_FNAME] = @global_yaml_pn.realpath.to_s
      @global_hash[ORIGINAL_OUTPUT_DIR] = @original_output_dir
#      @global_hash[TARGET_CMD_1_PN] = Pathname.new(@target_cmd1).realpath.to_s
#      @global_hash[TARGET_CMD_2_PN] = Pathname.new(@target_cmd2).realpath.to_s
      @global_hash[TARGET_CMD_1_PN] = Pathname.new(@target_cmd1).realpath.to_s
      @global_hash[TARGET_CMD_2_PN] = Pathname.new(@target_cmd2).realpath.to_s

      @global_hash[MAKE_ARG_X] = Mkspec::MAKE_ARG unless @global_hash[MAKE_ARG_X]
      @config = Config.new(SPEC_PN, @output_dir, @script_dir, @tad_dir).setup
      @tsv_path = Pathname.new(@tsv_fname)
      @tsv_path = @config.make_path_under_misc_dir(@tsv_path) unless @tsv_path.exist?

      @tsg = Mkspec::TestScriptGroup.new(@tsv_path, @start_char, @limit, @global_hash[MAKE_ARG_X]).setup
      @setting_and_testscript_array = make_array_of_setting_and_testscript(@tsg, @config)
    end

    def make_array_of_setting_and_testscript(tsg, config)
      tsg.testscripts.map do |testscript|
        setting = create_setting_instance(testscript, config)
        [setting, testscript]
      end
    end

    def create_setting_instance(testscript, config)
      setting = Mkspec::Setting.new(@global_hash, testscript, config)
      setting.setup("tecsgen command")
      setting
    end

    def create_files
      case @cmd
      when "all"
        template_and_data = true
        script = true
      when "tad"
        template_and_data = true
      else
        # scr
        script = true
      end
      create_all_template_and_data(@setting_and_testscript_array) if template_and_data && STATE.success?
      create_all_spec_file(@config, @setting_and_testscript_array) if script && STATE.success?
      STATE.success?
    end

    def create_all_template_and_data(array)
      error_count = 0
      array.map do |x|
        setting, _tmp = x
        setting.latest_testcase_id = @latest_testcase_id
        ret = make_template_and_data(setting)
        error_count += 1 unless ret
        @latest_testcase_id = setting.latest_testcase_id
      end
      error_count.zero?
    end

    def make_template_and_data(setting)
      setting.output_data_yamlfile
      make_template(setting)
    end

    def make_template(setting)
      templatex = Mkspec::Templatex.new(setting)
      ret = templatex.setup
      templatex.output if ret
    end

    def create_all_spec_file(config, array)
      error_count = 0
      array.map do |x|
        setting, testscript = x
        error_count += 1 unless make_spec_file(config, setting, testscript)
      end
      error_count.zero?
    end

    def make_spec_file(config, setting, testscript)
      ret = true
      data_yaml_path = setting.data_yaml_path
      return STATE.change(STATE.CANNOT_FIND_DATA_YAML_FILE) unless data_yaml_path.file?

      str = Root.new(data_yaml_path, config).result
      spec_fname = Util.make_spec_filename(testscript.name)
      spec_file_pn = config.make_path_under_script_dir(spec_fname)
      spec_file_pn.parent.mkdir unless spec_file_pn.parent.exist?
      begin
        str_2 = Mkscript.format(str)
      rescue StandardError => e
        message = %W[#{e.to_s} "Can't convert for #{spec_file_pn}"]
        Loggerxcm.error_b do
          #{message}
        end
        str_2 = str
        STATE.change(CANNOT_CONVERT_WITH_RUBO)
      end

      begin
        File.open(spec_file_pn.to_s, "w") { |file| file.write(str_2) }
      rescue StandardError => e
        message = %W[#{e.to_s} "Can't convert for #{spec_file_pn}"]
        Loggerxcm.error_b do
          #{message}
        end
        str_2 = str
        STATE.change(CANNOT_WRITE_SPEC_FILE)
      end
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
