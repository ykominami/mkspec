# frozen_string_literal: true

module Mkspec
  class Mkscript
    require "optparse"

    def initialize(argv)
      check_cli_options(argv)
      init if STATE.success?
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
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n")
        ]
        Loggerxcm.fatal(message)
        return STATE.change(Mkspec::INVALID_CMDLINE_OPTION_ERROR, "Invalid command line option")
      end
      raise Mkspec::MkspecDebugError unless STATE.success?

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_O, "not specified -o") unless @output_dir
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_T, "not specified -t") unless @tsv_fname
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "not specified -c") unless @cmd
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "invalid -c") unless command_options.find { |it| @cmd == it }
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_S, "not specified -s") unless @start_char
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_L, "not specified -l") unless @limit
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "not specified -g") unless @global_yaml_fname
      @global_yaml_pn = Pathname.new(@global_yaml_fname)
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "invalid -g") unless @global_yaml_pn.exist?
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_X, "not specified -x") unless @original_output_dir
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Y, "not specified -y") unless @target_cmd1
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Z, "not specified -z") unless @target_cmd2
    end

    def init
      @lt_id = -1

      @global_hash = Mkspec::Util.extract_in_yaml_file(@global_yaml_pn)
      @global_hash[GLOBAL_YAML_FNAME] = @global_yaml_pn.realpath.to_s
      @global_hash[ORIGINAL_OUTPUT_DIR] = @original_output_dir
      @global_hash[TARGET_CMD_1_PN] = Pathname.new(@target_cmd1).realpath.to_s
      @global_hash[TARGET_CMD_2_PN] = Pathname.new(@target_cmd2).realpath.to_s

      @global_hash[MAKE_ARG_X] = Mkspec::MAKE_ARG unless @global_hash[MAKE_ARG_X]
      config = Config.new(SPEC_PN, @output_dir, @script_dir, @tad_dir)
      @config = config.setup
      @tsv_path = Pathname.new(@tsv_fname)
      output_dir = @global_hash[ORIGINAL_OUTPUT_DIR]
      config = Config.new(SPEC_PN, output_dir, @script_dir, @tad_dir)
      @config = config.setup
      Loggerxcm.debug("### Mkscript init 0 @tad_dir=#{@tad_dir}")
      return unless STATE.success?
      index = @global_hash[TSV_PATH_INDEX_KEY]
      @tsv_path = Pathname.new(@global_hash[TSV_PATH][index])
      @tsv_path = @config.make_path_under_misc_dir(@tsv_path) unless @tsv_path.exist?

      @tsg = Mkspec::TestScriptGroup.new(@tsv_path, @start_char, @limit, @global_hash[MAKE_ARG_X]).setup
      return unless STATE.success?

      @tsg = TestScriptGroup.new(@tsv_path, @start_char, @limit, @global_hash[MAKE_ARG_X]).setup
      return unless STATE.success?
      @setting_and_testscript_array = make_array_of_setting_and_testscript(@tsg, @config)
    end

    def make_array_of_setting_and_testscript(tsg, config)
      lt_id = -1
      tsg.testscripts.map do |testscript|
        setting = create_setting_instance(testscript, config, lt_id)
        lt_id = setting.lt_id
        [setting, testscript]
      end
    end

    def create_setting_instance(testscript, config, initail_testcase_id)
      setting = Mkspec::Setting.new(@global_hash, testscript, config, initail_testcase_id)
      setting.setup("tecsgen command")
      setting
    end

    def create_files
      case @cmd
      when "all"
        template_and_data = true
        spec = true
      when "tad"
        template_and_data = true
        data_dir_index = 0
      when "spec"
        spec = true
        data_dir_index = 0
      when "all-2"
        template_and_data = true
        spec = true
        data_dir_index = 1
      when "tad-2"
        template_and_data = true
        data_dir_index = 1
      when "spec-2"
        spec = true
        data_dir_index = 1
      else
        # scr
        spec = true
      end
      Loggerxcm.debug("template_and_data=#{template_and_data}")
      Loggerxcm.debug("spec=#{spec}")
      Loggerxcm.debug("data_dir_index=#{data_dir_index}")
      raise MkspecDebugError unless STATE.success?

      if template_and_data && STATE.success?
        create_all_template_and_data(@setting_and_testscript_array)
        raise MkspecDebugError unless STATE.success?
      end
      raise MkspecDebugError unless STATE.success?
      Loggerxcm.debug("spec=#{spec}")
      if spec && STATE.success?
        #raise MkspecDebugError #unless STATE.success?
        errors = create_all_spec_file(@config, @setting_and_testscript_array)
        Loggerxcm.debug("errors.size=#{errors.size}")
        if errors.size > 0
          errors.map { |element|
            setting, testscript = element
          }
          raise MkspecDebugError
        end
      end
      #raise MkspecDebugError #unless STATE.success?

      [template_and_data, spec, data_dir_index]
    end

    def create_all_template_and_data(array)
      array.inject([]) do |errors, element|
        setting, _tmp = element
        ret = make_template_and_data(setting)
        errors << x unless ret
        errors
      end
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
      array.inject([]) do |errors, element|
        setting, testscript = element
        ret = make_spec_file(config, setting, testscript)
        errors << x unless ret
        errors
      end
    end

    def format_ruby_script(spec_file_pn, str)
      str_2 = nil
      begin
        str_2 = Mkscript.format(str)
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n"),
          '-- str S',
          str,
          '-- str E',
          "Can't convert for #{spec_file_pn}"
        ]
        Loggerxcm.fatal(message)
        str_2 = str
        STATE.change(Mkspec::CANNOT_CONVERT_WITH_RUBO, "Can't reformat ruby script")
      end
      raise Mkspec::MkspecDebugError unless STATE.success?
      str_2
    end

    def output_ruby_script(spec_file_pn, str)
      begin
        File.open(spec_file_pn.to_s, "w") { |file| file.write(str) }
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n"),
          "Can't convert for #{spec_file_pn}"
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_WRITE_SPEC_FILE, "Can not write spec file(#{spec_file_pn.to_s})")
      end
      raise Mkspec::MkspecDebugError unless STATE.success?
      true
    end

    def make_spec_file(config, setting, testscript)
      ret = true
      data_yaml_path = setting.data_yaml_path
      Loggerxcm.debug("Mkscript#make_spec_file")
      Loggerxcm.debug("data_yaml_path=#{data_yaml_path}")
      Loggerxcm.debug("Mkscript#make_spec_file")
      Loggerxcm.debug("data_yaml_path=#{data_yaml_path}")
      Loggerxcm.debug("config=#{config}")
      str = Root.new(data_yaml_path, config).result
      spec_fname = Util.make_spec_filename(testscript.name)
      spec_file_pn = config.make_path_under_script_dir(spec_fname)
      spec_file_pn.parent.mkdir unless spec_file_pn.parent.exist?
      Loggerxcm.debug("spec_file_pn=#{spec_file_pn}")
      Loggerxcm.debug("str=#{str}")
      str_2 = nil
      if str
        begin
          str_2 = format_ruby_script(spec_file_pn, str)
          Loggerxcm.debug("### #{spec_file_pn} str2")
          Loggerxcm.debug(str_2)
          Loggerxcm.debug("### END")
        rescue StandardError => e
          message = [
            e.message,
            e.backtrace.join("\n"),
          ]
          Loggerxcm.fatal(message)
          STATE.change(Mkspec::CANNOT_FORMAT_WITH_ERUBY, "Can not format a ruby script(#{spec_file_pn.to_s})")
        end
        raise MkspecAppError unless STATE.success?
      else
        STATE.change(Mkspec::CANNOT_FORMAT_WITH_ERUBY, "Can not format a ruby script(#{spec_file_pn.to_s})")
        raise MkspecAppError unless STATE.success?
      end

      if str_2
        output_ruby_script(spec_file_pn, str_2)
      else
        STATE.change(Mkspec::CANNOT_FORMAT_WITH_ERUBY, "Can not format a ruby script(#{spec_file_pn.to_s})")
        raise MkspecAppError unless STATE.success?
      end
    end

    def self.format(code)
      Rufo::Formatter.format(code, {})
    end
  end
end
