# frozen_string_literal: true

module Mkspec
  class Mkscript
    require "optparse"

    attr_accessor :gco

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

      opt.banner = "Usage: ruby #{$PROGRAM_NAME} -o output_dir -t tsv -c cmd -s ch -l limit -d script_dir -r resolved_top_dir_yaml -i tad_dir -g global_yaml -x original_output_dir -y target_cmd1 -z target_cmd2 -D top_dir_yaml -G specific_yaml -L log_dir"

      opt.on("-o output_dir", "output directory") { |x| @output_dir = x }
      opt.on("-t tsv", "tsv file") { |x| @tsv_fname = x }
      opt.on("-c cmd", "command") { |x| @cmd = x }
      opt.on("-s ch", "start-char") { |x| @start_char = x }
      opt.on("-l limit", "limit") { |x| @limit = x.to_i }
      opt.on("-d script_dir", "script directory") { |x| @script_dir = x }
      opt.on("-r resolved_top_dir_yaml", "resolved top dir yamlfile") { |x| @resolved_top_dir_yaml_fname = x }
      opt.on("-i tad_dir", "limit") { |x| @tad_dir = x }
      opt.on("-g global_yaml", "global yamlfile") { |x| @global_yaml_fname = x }
      opt.on("-x original_output_dir", "original output dir") { |x| @original_output_dir = x }
      opt.on("-y target_cmd1", "path of target command 1") { |x| @target_cmd1 = x }
      opt.on("-z target_cmd2", "path of target command 2") { |x| @target_cmd2 = x }
      opt.on("-D top_dir_yaml", "top dir yamlfile") { |x| @top_dir_yaml_fname = x }
      opt.on("-G specific_yaml", "specific yamlfile") { |x| @specific_yaml_fname = x }
      opt.on("-L log_dir", "limit") { |x| @log_dir = x }
      opt.on("-v") { |_x| @version = Mkspec::VERSION }

      begin
        opt.parse!(argv)
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace
        ]
        # Loggerxcm.fatal(message)
        Loggerxcm.show(message)
        puts(message)
        return STATE.change(Mkspec::INVALID_CMDLINE_OPTION_ERROR, "Invalid command line option")
      end

      return STATE.change(Mkspec::FINISH, %(version #{@version})) if @version

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_O, "not specified -o") unless @output_dir
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_T, "not specified -t") unless @tsv_fname
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "not specified -c") unless @cmd
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_C, "invalid -c") unless cmd_options.find { |it| @cmd == it }
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_S, "not specified -s") unless @start_char
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_L, "not specified -l") unless @limit
      # -d
      # -i
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "not specified -g") unless @global_yaml_fname

      @global_yaml_pn = Pathname.new(@global_yaml_fname)
      # exit
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_G, "invalid -g") unless @global_yaml_pn.exist?
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_X, "not specified -x") unless @original_output_dir
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Y, "not specified -y") unless @target_cmd1
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_Z, "not specified -z") unless @target_cmd2

      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_DD, "not specified -D") unless @top_dir_yaml_fname

      @top_dir_yaml_pn = Pathname.new(@top_dir_yaml_fname)
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_DD, "invalid -D") unless @top_dir_yaml_pn.exist?
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_GG, "not specified -G") unless @specific_yaml_fname

      @resolved_top_dir_yaml_pn = Pathname.new(@resolved_top_dir_yaml_fname) if @resolved_top_dir_yaml_fname

      @specific_yaml_pn = Pathname.new(@specific_yaml_fname)
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_GG, "invalid -G") unless @specific_yaml_pn.exist?
      return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_LL, "not specified -L") unless @log_dir

      if Util.not_empty_string?(@log_dir).first
        @log_dir_pn = Pathname.new(@log_dir).expand_path
        return STATE.change(Mkspec::CMDLINE_OPTION_ERROR_LL, "invalid -L") unless @log_dir_pn.exist?
      end
      unless @log_dir_pn
        @log_dir = if valid_dir?(ENV['MKSPEC_LOG_DIR'])
                     ENV['MKSPEC_LOG_DIR']
                   else
                     "."
                   end
        @log_dir_pn = Pathname.new(@log_dir).expand_path
      end
#      Loggerxcm.init("mk_", :default, @log_dir_pn, false, :error)
      Loggerxcm.init("mk_", :default, @log_dir_pn, false, :debug)
      Loggerxcm.error("argv=#{argv_dup}")
      Loggerxcm.error("argv_str=#{argv_dup.join(' ')}")
    end

    def valid_dir?(path)
      path && path.strip.size.positive? && Pathname.new(path).exist?
    end

    def init_sub(gco, config, tsv_path, tad_dir,  start_char, limit, make_arg_x, cmd = nil)
      @cmd = cmd if cmd
      @config = config.setup
      Loggerxcm.debug("### Mkscript init 0 tad_dir=#{tad_dir}")
      return unless STATE.success?

      @tsv_path = tsv_path
      @tsv_path = @config.make_path_under_misc_dir(@tsv_path) unless @tsv_path.exist?

      @tsg = Mkspec::TestScriptGroup.new(@tsv_path, start_char, limit, make_arg_x).setup
      return unless STATE.success?

      @setting_and_testscript_array = make_array_of_setting_and_testscript(gco, @tsg, @config)
    end

    def init
      @lt_id = -1
      @gco = GlobalConfig.new(@top_dir_yaml_pn, @resolved_top_dir_yaml_pn, @specific_yaml_pn, @global_yaml_pn, @target_cmd1, @target_cmd2, nil)

      config = Config.new(@gco.ost.top_dir, @gco.ost.data_top_dir, @gco.ost.output_data_top_dir, @output_dir, @script_dir,
                          @tad_dir)
      init_sub(@gco, config, @gco.tsv_path, @tad_dir,  @start_char, @limit, @gco.make_arg_x)
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
      raise( MkspecDebugError, "mkscript.rb 1 #{STATE.message}") unless STATE.success?

      if template_and_data && STATE.success?
        create_all_template_and_data(@setting_and_testscript_array)
        raise(MkspecDebugError, "mkscript.rb 2 #{STATE.message}") unless STATE.success?
      end
      #raise( MkspecDebugError, "mkscript.rb 3 #{STATE.message}") unless STATE.success?
      Loggerxcm.debug("spec=#{spec}")

      ret = true
      if spec && STATE.success?
        ret = create_all_spec_file(@config, @setting_and_testscript_array)
        Loggerxcm.debug("1 ret=#{ret} spec=#{spec}")
      end
      raise( MkspecDebugError, "mkscript.rb 4 ret=#{ret}") unless ret

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

      array.each do |element|
        ret = false

        setting, testscript = element
        begin
          ret = make_spec_file(config, setting, testscript)
          error_count += 1 unless ret
        rescue StandardError => e
          message = [
            e.message,
            e.backtrace
          ]
          message2 = message
          Loggerxcm.fatal(message2)
          STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, "Can't make a spec file(message=#{message2}")
          exit_flag = true
          error_count += 1
        end
        break if exit_flag
      end
      raise( Mkspec::MkspecDebugError, "mkscript.rb 10 #{STATE.message}") unless STATE.success?

      error_count.zero?
    end

    def format_ruby_script(spec_file_pn, str)
      str_2 = nil
      begin
        str_2 = Mkscript.format(str)
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace,
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
        spec_file_pn_ = Pathname.new( "#{spec_file_pn}_" )
        File.write(spec_file_pn_.to_s, str)
        FileUtils.move(spec_file_pn_.to_s, spec_file_pn.to_s)
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace,
          "Can't convert for #{spec_file_pn}"
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_WRITE_SPEC_FILE, "Can not write spec file(#{spec_file_pn})")
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
          e.backtrace
        ]
        message2 = message
        Loggerxcm.fatal(message2)
#        STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, "Can not make a ruby script from data_yaml_path(#{data_yaml_path.to_s})")
        STATE.change(Mkspec::CANNOT_MAKE_SPEC_FILE, message2)
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
          e.backtrace
        ]
        Loggerxcm.fatal(message)
        STATE.change(Mkspec::CANNOT_FORMAT_WITH_ERUBY, "Can not format a ruby script(#{spec_file_pn})")
      end
      raise( MkspecAppError , "mkscript.rb 8 #{STATE.message}" ) if !str_2 && !STATE.success?

      output_ruby_script(spec_file_pn, str_2)
    end

    def self.format(code)
#      Rufo::Formatter.format(code, {})
      Rufo::Formatter.format(code)
    end
  end
end
