# frozen_string_literal: true

module Mkspec
  class Mkscript
    require "optparse"

    def initialize(argv)
      check_cli_options(argv)
      init if STATE.success?
    end

    def check_state_and_show_useage_and_state_message
      exit_code = nil
      str = ["", @opt.banner].join("\n")
      exit_code = STATE.show_message(str) unless STATE.success?
      exit_code
    end

    def check_cli_options(argv)
      argv_dup = argv.dup
      #
      cmd_options = %w[ spec tad all ]
      opt = OptionParser.new
      #
      @opt = opt
      #
      opt.banner = "Usage: ruby #{$PROGRAM_NAME} -o output_dir -d script_dir -i tad_dir -t tsv_fname -T original_top_dir -c (all|tad|scr) -s char -l limit -L log_dir -x original_output_dir -y target_cmd_1_pn -z target_cmd_1_pn"
      opt.on("-o output_dir", "output directory") { |x| @output_dir = x }
      opt.on("-d script_dir", "script directory") { |x| @script_dir = x }
      opt.on("-i tad_dir", "limit") { |x| @tad_dir = x }
      opt.on("-t tsv", "tsv file") { |x| @tsv_fname = x }
      opt.on("-T top_dir", "original top dir") { |x| @original_top_dir = x }
      opt.on("-c cmd", "command") { |x| @cmd = x }
      opt.on("-s ch", "start-char") { |x| @start_char = x }
      opt.on("-l limit", "limit") { |x| @limit = x.to_i }
      opt.on("-L log_dir", "limit") { |x| @log_dir = x }
      opt.on("-g global_yaml", "global yamlfile") { |x| @global_yaml_fname = x }
      opt.on("-G specific_yaml", "specific yamlfile") { |x| @specific_yaml_fname = x }
      opt.on("-x original_output_dir", "original output dir") { |x| @original_output_dir = x }
      opt.on("-y target_cmd1", "path of target command 1") { |x| @target_cmd1 = x }
      opt.on("-z target_cmd2", "path of target command 2") { |x| @target_cmd2 = x }
      begin
        opt.parse!(argv)
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n")
        ]
        #Loggerxcm.fatal(message)
        return STATE.change(Mkspec::INVALID_CMDLINE_OPTION_ERROR, "Invalid command line option")
      end

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_O, "not specified -o") unless @output_dir
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_T, "not specified -t") unless @tsv_fname
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_TT, "not specified -T") unless @original_top_dir
      @original_top_dir_pn = Pathname.new(@original_top_dir)
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_TT, "invalid -T") unless @original_top_dir_pn.exist?
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "not specified -c") unless @cmd
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "invalid -c") unless cmd_options.find { |it| @cmd == it }
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_S, "not specified -s") unless @start_char
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_L, "not specified -l") unless @limit

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_GG, "not specified -G") unless @specific_yaml_fname
      @specific_yaml_pn = Pathname.new(@specific_yaml_fname)
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_GG, "invalid -G") unless @specific_yaml_pn.exist?

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "not specified -g") unless @global_yaml_fname
      @global_yaml_pn = Pathname.new(@global_yaml_fname)
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "invalid -g") unless @global_yaml_pn.exist?

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_X, "not specified -x") unless @original_output_dir
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Y, "not specified -y") unless @target_cmd1
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Z, "not specified -z") unless @target_cmd2

      if Util.not_empty_string?(@log_dir).first
        @log_dir_pn = Pathname.new(@log_dir)
        unless @log_dir_pn.exist?
          return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_LL, "invalid -L")
        end
      end
      unless @log_dir_pn
        if valid_dir?(ENV['MKSPEC_LOG_DIR'])
          @log_dir = ENV['MKSPEC_LOG_DIR']
        else
          @log_dir = "."
        end
        @log_dir_pn = Pathname.new(@log_dir)
      end
#      Loggerxcm.init("mk_", :default, @log_dir_pn, false, :error)
      Loggerxcm.init("mk_", :default, @log_dir_pn, false, :debug)
      Loggerxcm.error("argv=#{argv_dup}")
      Loggerxcm.error("argv_str=#{argv_dup.join(' ')}")

    end

    def valid_dir?(path)
      path && path.strip.size > 0 && Pathname.new(path).exist?
    end

    def init
      @lt_id = -1
      @gc = GlobalConfig.new(@specific_yaml_pn, @global_yaml_pn, @target_cmd1, @target_cmd2, nil, @original_top_dir)

      config = Config.new(@gc.o.top_dir_pn, @gc.o.data_top_dir_pn, @output_dir, @script_dir, @tad_dir)
      @config = config.setup
      @tsv_path = Pathname.new(@tsv_fname)
      output_dir = @gc.output_dir
      Loggerxcm.debug("### Mkscript init 0 @tad_dir=#{@tad_dir}")
      return unless STATE.success?

      @tsv_path = @gc.tsv_path
      @tsv_path = @config.make_path_under_misc_dir(@tsv_path) unless @tsv_path.exist?

      @tsg = Mkspec::TestScriptGroup.new(@tsv_path, @start_char, @limit, @gc.make_arg_x).setup
      return unless STATE.success?

      @tsg = TestScriptGroup.new(@tsv_path, @start_char, @limit, @gc.make_arg_x).setup
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
      setting = Mkspec::Setting.new(@gc, testscript, config, initail_testcase_id)
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
      raise( MkspecDebugError, "mkscript.rb 1 #{STATE.message}") unless STATE.success?

      if template_and_data && STATE.success?
        create_all_template_and_data(@setting_and_testscript_array)
        raise(MkspecDebugError, "mkscript.rb 2 #{STATE.message}") unless STATE.success?
      end
      raise( MkspecDebugError, "mkscript.rb 3 #{STATE.message}") unless STATE.success?
      Loggerxcm.debug("spec=#{spec}")
      if spec && STATE.success?
        errors = create_all_spec_file(@config, @setting_and_testscript_array)
        Loggerxcm.debug("errors.size=#{errors.size}")
        if errors.size > 0
          errors.map { |element|
            setting, testscript = element
          }
          raise( MkspecDebugError, "mkscript.rb 4")
        end
      end

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
      exit_flag = false
      array.each do |element|
        setting, testscript = element
        begin
          ret = make_spec_file(config, setting, testscript)
        rescue StandardError => e
          message = [
            e.message,
            e.backtrace.join("\n"),
          ]
          Loggerxcm.fatal(message)
          STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, "Can't make a spec file(message=#{message}")
          exit_flag = true
        end
        break if exit_flag
      end
      raise( Mkspec::MkspecDebugError, "mkscript.rb 10 #{STATE.message}") unless STATE.success?
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
        #STATE.change(Mkspec::CANNOT_CONVERT_WITH_RUBO, "Can't reformat ruby script")
      end
      raise( Mkspec::MkspecDebugError, "mkscript.rb 5 #{STATE.message}") unless STATE.success?
      str_2
    end

    def output_ruby_script(spec_file_pn, str)
      begin
        spec_file_pn_ = Pathname.new( spec_file_pn.to_s + "_" )
        File.open(spec_file_pn_.to_s, "w") { |file| file.write(str) }
        FileUtils.move(spec_file_pn_.to_s, spec_file_pn.to_s)
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n"),
          "Can't convert for #{spec_file_pn}"
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_WRITE_SPEC_FILE, "Can not write spec file(#{spec_file_pn.to_s})")
      end
      raise( Mkspec::MkspecDebugError, "mkscript.rb 6 #{STATE.message}") unless STATE.success?
      true
    end

    def make_spec_file(config, setting, testscript)
      ret = true
      str = nil
      data_yaml_path = setting.data_yaml_path
      Loggerxcm.debug("Mkscript#make_spec_file")
      Loggerxcm.debug("data_yaml_path=#{data_yaml_path}")
      Loggerxcm.debug("Mkscript#make_spec_file")
      Loggerxcm.debug("data_yaml_path=#{data_yaml_path}")
      Loggerxcm.debug("config=#{config}")
      begin
        str = Root.new(data_yaml_path, config).result
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n"),
        ]
        Loggerxcm.fatal(message)
#        STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, "Can not make a ruby script from data_yaml_path(#{data_yaml_path.to_s})")
        STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, message)
     end

      raise(MkspecAppError , "mkscript.rb 7 #{STATE.message}") unless STATE.success?

      spec_fname = Util.make_spec_filename(testscript.name)
      spec_file_pn = config.make_path_under_script_dir(spec_fname)
      spec_file_pn.parent.mkdir unless spec_file_pn.parent.exist?
      Loggerxcm.debug("spec_file_pn=#{spec_file_pn}")
      Loggerxcm.debug("str=#{str}")
      begin
        str_2 = format_ruby_script(spec_file_pn, str)
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n"),
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_FORMAT_WITH_ERUBY, "Can not format a ruby script(#{spec_file_pn.to_s})")
      end
      unless str_2
        raise( MkspecAppError , "mkscript.rb 8 #{STATE.message}" ) unless STATE.success?
      end
      output_ruby_script(spec_file_pn, str_2)
    end

    def self.format(code)
#      Rufo::Formatter.format(code, {})
      Rufo::Formatter.format(code)
    end
  end
end
