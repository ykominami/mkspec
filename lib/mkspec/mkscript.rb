# frozen_string_literal: true

require "pathname"

module Mkspec
  class Mkscript
    require "optparse"

    attr_accessor :gco, :new_count

    def check_state_and_show_useage_and_state_message
      exit_code = nil
      if STATE.finish?
        exit_code = STATE.show_message
      elsif !STATE.success?
        array = ["", @opt.banner]
        exit_code = STATE.show_message(array)
      end
      exit_code
    end

    def check_cli_options(argv)
      argv_dup = argv.dup
      cmd_options = %w[spec tad all]
      opt = OptionParser.new
      @opt = opt
      @version = nil
      @new_count = false

      opt.banner = "Usage: ruby #{$PROGRAM_NAME} -o output_dir -t tsv -c cmd -s ch -l limit -d script_dir -i tad_dir -g global_yaml -x original_output_dir -y target_cmd_1 -z target_cmd_2 -G specific_yaml -L log_dir -n"

      opt.on("-o output_dir", "output directory") { |x| @output_dir = x }
      opt.on("-t tsv", "tsv file") { |x| @tsv_fname = x }
      opt.on("-c cmd", "command") { |x| @cmd = x }
      opt.on("-s ch", "start-char") { |x| @start_char = x }
      opt.on("-l limit", "limit") { |x| @limit = x.to_i }
      opt.on("-d script_dir", "script directory") { |x| @script_dir = x }
      opt.on("-i tad_dir", "limit") { |x| @tad_dir = x }
      opt.on("-g global_yaml", "global yamlfile") { |x| @global_yaml_fname = x }
      opt.on("-x original_output_dir", "original output dir") { |x| @original_output_dir = x }
      opt.on("-y target_cmd_1", "path of target command 1") { |x| @target_cmd_1 = x }
      opt.on("-z target_cmd_2", "path of target command 2") { |x| @target_cmd_2 = x }
      opt.on("-G specific_yaml", "specific yamlfile") { |x| @specific_yaml_fname = x }
      opt.on("-L log_dir", "limit") { |x| @log_dir = x }
      opt.on("-n") { |_x| @new_count = true }
      opt.on("-v") { |_x| @version = Mkspec::VERSION }

      begin
        opt.parse!(argv)
      rescue StandardError => exc
        message = [
          exc.message,
          exc.backtrace
        ]
        # Loggerxcm.fatal(message)
        Loggerxcm.show(message)
        return STATE.change(Mkspec::INVALID_CMDLINE_OPTION_ERROR, "Invalid command line option")
      end

      return STATE.change(Mkspec::FINISH, %(version #{@version})) if @version

      _top_dir_yaml_file, _resolved_top_dir_yaml_file, specific_yaml_file, global_yaml_file = Util.adjust_paths

      @global_yaml_fname ||= global_yaml_file.full_path
      @specific_yaml_fname ||= specific_yaml_file.full_path

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "not specified -g") unless @global_yaml_fname

      @global_yaml_pn = global_yaml_file.pathname
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "invalid -g") unless @global_yaml_pn.exist?

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_GG, "not specified -G") unless @specific_yaml_fname

      @specific_yaml_pn = specific_yaml_file.pathname
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_GG, "invalid -G") unless @specific_yaml_pn.exist?

      init_hash = config_from_environmental_varialbes
      @gco = GlobalConfig.new(@new_count, init_hash, @specific_yaml_pn, @global_yaml_pn, nil)

      ost = @gco.ost
      @output_dir ||= ost.output_dir
      @tsv_fname ||= ost.tsv_fname
      @start_char ||= ost.start_char
      @limit ||= ost.limit
      @original_output_dir ||= ost.original_output_dir
      @target_cmd_1 ||= ost.tecsgen_cmd
      @target_cmd_2 ||= ost.tecsgen_merge_cmd
      @log_dir ||= ost.log_dir
      @cmd ||= ost.cmd
      @start_char ||= ost.start_char
      @limit ||= ost.limit

      @target_cmd_1 ||= ost.target_cmd_1
      @target_cmd_2 ||= ost.target_cmd_2
      @tad_dir ||= ost.tad_dir
      @script_dir = ost.script_dir
      @output_script_dir = ost.output_script_dir
      @output_template_and_data_dir_pn = ost.output_template_and_data_dir_pn

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_O, "not specified -o") unless @output_dir
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_T, "not specified -t") unless @tsv_fname
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "not specified -c") unless @cmd
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "invalid -c") unless cmd_options.find { |it| @cmd == it }
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_S, "not specified -s") unless @start_char
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_L, "not specified -l") unless @limit
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Y, "not specified -y") unless @target_cmd_1
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Z, "not specified -z") unless @target_cmd_2
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_I, "not specified -i") unless @tad_dir

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_X, "not specified -x") unless @original_output_dir

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_LL, "not specified -L") unless @log_dir

      if Util.not_empty_string?(@log_dir).first
        @log_dir_pn = Pathname.new(@log_dir).expand_path
        return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_LL, "invalid -L") unless @log_dir_pn.exist?
      end
      return STATE.change(Mkspec::FINISH, @version.to_s) unless @original_output_dir

      if @log_dir_pn.nil?
        dir = ENV.fetch("MKSPEC_LOG_DIR")

        @log_dir = if valid_dir?(dir)
                     dir
                   else
                     "."
                   end
        @log_dir_pn = Pathname.new(@log_dir).expand_path
      end
      Loggerxcm.init("mk_", :default, @log_dir_pn, false, :debug)
      Loggerxcm.error("argv=#{argv_dup}")
      Loggerxcm.error("argv_str=#{argv_dup.join(' ')}")
    end

    def config_from_environmental_varialbes
      top_dir_yaml_file, resolved_top_dir_yaml_file, _specific_yaml_file, _global_yaml_file = Util.adjust_paths
      Util.make_hash_from_files(top_dir_yaml_file, resolved_top_dir_yaml_file)
    end

    def valid_dir?(path)
      path && path.strip.size.positive? && Pathname.new(path).exist?
    end

    def init_sub(gco, config, tsv_path, tad_dir, start_char, limit, make_arg, cmd = nil)
      @cmd = cmd if cmd
      return false if config.nil?

      @config = config.setup
      Loggerxcm.debug("### Mkscript init 0 tad_dir=#{tad_dir}")
      return false unless STATE.success?

      @tsv_path = tsv_path
      @tsv_path = @config.make_path_under_misc_dir(@tsv_path) unless @tsv_path.exist?

      @tsg = Mkspec::TestScriptGroup.new(@tsv_path, start_char, limit, make_arg).setup
      return false unless STATE.success?

      @setting_and_testscript_array = make_array_of_setting_and_testscript(gco, @tsg, @config)

      true
    end

    def init
      Loggerxcm.debug("Config#init @gco.ost.top_dir=#{@gco.ost.top_dir}")
      raise MkspecAppError, "Config#init @gco.ost.top_dir=#{@gco.ost.top_dir}" unless @gco.ost.top_dir

      # @gco.ost.top_dir,
      config = Config.new(
        @gco.ost.data_top_dir,
        @gco.ost.output_data_top_dir,
        @output_dir,
        @output_script_dir,
        @output_template_and_data_dir_pn
      )

      init_sub(@gco, config, @gco.tsv_path, @tad_dir, @start_char, @limit, @gco.make_arg)
    end

    def make_array_of_setting_and_testscript(gco, tsg, config)
      lt_id = -1
      tsg.testscripts.map do |testscript|
        setting = create_setting_instance(gco, testscript, config, lt_id)
        lt_id = setting.lt_id
        [setting, testscript]
      end
    end

    def create_setting_instance(gco, testscript, config, initail_testcase_id)
      setting = Mkspec::Setting.new(gco, testscript, config, initail_testcase_id)
      setting.setup("tecsgen command")
      setting
    end

    def create_files
      raise if @config.nil?

      case @cmd
      when "all"
        # template_and_data の後 spec
        template_and_data = true
        spec = true
      when "tad"
        # template_and_data のみ
        template_and_data = true
        data_dir_index = 0
        spec = false
      when "spec"
        # spec のみ
        spec = true
        data_dir_index = 0
      when "all-2"
        # template_and_data の後 spec
        # 2番目のデータディレクトリを使用
        template_and_data = true
        spec = true
        data_dir_index = 1
      when "tad-2"
        # template_and_data のみ
        # 2番目のデータディレクトリを使用
        template_and_data = true
        data_dir_index = 1
        spec = false
      when "spec-2"
        # spec のみ
        # 2番目のデータディレクトリを使用
        spec = true
        data_dir_index = 1
      else
        # scr
        spec = true
      end
      Loggerxcm.debug("template_and_data=#{template_and_data}")
      Loggerxcm.debug("spec=#{spec}")
      Loggerxcm.debug("data_dir_index=#{data_dir_index}")
      # raise MkspecDebugError.new("mkscript.rb 1 ", STATE.message_array) unless STATE.success?
      return nil unless STATE.success?

      if template_and_data && STATE.success?
        return nil if @setting_and_testscript_array.nil?

        create_all_template_and_data(@setting_and_testscript_array)
        # raise MkspecDebugError.new("mkscript.rb 2", STATE.message_array) unless STATE.success?
        return nil unless STATE.success?
      end
      #raise( MkspecDebugError, "mkscript.rb 3 #{STATE.message}") unless STATE.success?
      Loggerxcm.debug("spec=#{spec}")

      ret = true
      if spec && STATE.success?
        raise if @config.nil?

        # binding.break
        ret = create_all_spec_file(@config, @setting_and_testscript_array)
        Loggerxcm.debug("1 ret=#{ret} spec=#{spec}")
      end
      # raise MkspecDebugError.new("mkscript.rb 4 ret=#{ret}") unless ret
      return nil unless ret

      [template_and_data, spec, data_dir_index]
    end

    def create_all_template_and_data(array)
      array.each_with_object([]) do |element, errors|
        setting, _tmp = element
        ret = make_template_and_data(setting)
        errors << x unless ret
      end
    end

    def make_template_and_data(setting)
      setting.output_data_yamlfile
      make_template(setting)
    end

    def make_template(setting)
      templatex = Mkspec::Templatex.new(setting, @config)
      ret = templatex.setup
      templatex.output if ret
    end

    def create_all_spec_file(config, array)
      error_count = 0
      exit_flag = false

      message = []
      array.each do |element|
        setting, testscript = element

        begin
          ret = make_spec_file(config, setting, testscript)
          error_count += 1 unless ret
        rescue StandardError => exc
          message = [
            exc.message,
            exc.backtrace
          ]
          Loggerxcm.fatal(exc.message)
          # Loggerxcm.fatal( exc.backtrace.join('\n') )
          Loggerxcm.fatal(exc.backtrace)

          message2 = message
          Loggerxcm.fatal(message2)
          STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, "Can't make a spec file(#{error_count})", message2)
          exit_flag = true
          error_count += 1
        end
        break if exit_flag
      end
      Loggerxcm.debug("error_count=#{error_count}")
      Loggerxcm.debug("message=#{message}")
      puts "STATE.success=#{STATE.exit_code}" unless STATE.success?
      raise Mkspec::MkspecDebugError.new("mkscript.rb 10", STATE.message_array) unless STATE.success?

      error_count.zero?
    end

    def format_ruby_script(spec_file_pn, str)
      str_2 = nil
      begin
        str_2 = Mkscript.format(str)
      rescue StandardError => exc
        message = [
          exc.message,
          exc.backtrace,
          "-- str S",
          str,
          "-- str E",
          "Can't convert for #{spec_file_pn}"
        ]
        Loggerxcm.fatal(message)
        str_2 = str
      end
      raise Mkspec::MkspecDebugError.new("mkscript.rb 5 ", STATE.message_array) unless STATE.success?

      str_2
    end

    def output_ruby_script(spec_file_pn, str)
      begin
        spec_file_pn_ = Pathname.new("#{spec_file_pn}_")
        File.write(spec_file_pn_.to_s, str)
        FileUtils.move(spec_file_pn_.to_s, spec_file_pn.to_s)
      rescue StandardError => exc
        message = [
          exc.message,
          exc.backtrace,
          "Can't convert for #{spec_file_pn}"
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_WRITE_SPEC_FILE, "Can not write spec file", spec_file_pn)
      end
      raise Mkspec::MkspecDebugError.new("mkscript.rb 6 ", STATE.message_array) unless STATE.success?

      true
    end

    def make_spec_file(config, setting, testscript)
      str = nil
      data_yaml_path = setting.data_yaml_path
      Loggerxcm.debug("Mkscript#make_spec_file")
      Loggerxcm.debug("data_yaml_path=#{data_yaml_path}")
      Loggerxcm.debug("Mkscript#make_spec_file")
      Loggerxcm.debug("data_yaml_path=#{data_yaml_path}")
      Loggerxcm.debug("config=#{config}")
      begin
        str = Root.new(data_yaml_path, config).result
      rescue StandardError => exc
        Loggerxcm.fatal("data_yaml_path=#{data_yaml_path}")
        message = [
          "data_yaml_path=#{data_yaml_path}",
          exc.message,
          exc.backtrace
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, message)
      end
      Loggerxcm.debug("=== S")
      STATE.message_array.map { |mes| Util.puts_valid_str mes }
      Loggerxcm.debug("=== E")
      raise MkspecAppError.new("mkscript.rb 7 ", STATE.message_array) unless STATE.success?

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
          e.backtrace
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_FORMAT_WITH_ERUBY, "Can not format a ruby script", spec_file_pn)
      end
      raise MkspecAppError.new("mkscript.rb 8 ", STATE.message_array) if str_2.nil? && !STATE.success?

      output_ruby_script(spec_file_pn, str_2)
    end

    def self.format(code)
      #      Rufo::Formatter.format(code, {})
      Rufo::Formatter.format(code)
    end
  end
end
