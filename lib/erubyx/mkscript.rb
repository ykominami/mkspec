# frozen_string_literal: true
module Erubyx
  class Mkscript
    require 'optparse'

    def print_debug
      puts "tsv_fname=#{@tsv_fname}"
      puts "output_dir=#{@output_dir}"
      puts "cmd=#{@cmd}"
    end

    def show_usage_and_exit(o, message)
      puts message
      puts o.banner
      exit Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
    end

    def initialize(argv)
      @cmd = "detect"
      opt = OptionParser.new
      opt.banner = "ruby #{$0} -d dir -t tsv_fname -c (detect|all|partial) -s char -l limit"
      opt.on('-d dir', 'output directory'){|x| @output_dir = x}
      opt.on('-t tsv', 'tsv file'){|x| @tsv_fname = x}
      opt.on('-c cmd', 'command'){|x| @cmd = x}
      opt.on('-s ch', 'start-char'){|x| @start_char = x}
      opt.on('-l limit', 'limit'){|x| @limit = x.to_i}
      opt.parse!(argv)

      unless @output_dir
        show_usage_and_exit(opt, "A")
      end
      unless @tsv_fname
        show_usage_and_exit(opt, "B")
      end
      unless @cmd
        show_usage_and_exit(opt, "C")
      end
      unless @start_char
        show_usage_and_exit(opt, "D")
      end
      unless @limit
        show_usage_and_exit(opt, "E")
      end

      @make_arg = Erubyx::MAKE_ARG

      @config = Config.new( @output_dir )
      @tsv_path = Pathname.new(@tsv_fname)

      unless @tsv_path.exist?
        @tsv_path = @config.make_path_under_setting_dir( @tsv_path )
      end


      @tsg = Erubyx::TestScriptGroup.new( @tsv_path, @start_char, @limit, @make_arg )
      @tsg.setup
    end

    def do_process
      if @cmd == "all"
        process_all(@tsg, @config, @make_arg)
      elsif @cmd == "detect"
        process_detect(@tsg, @make_arg)
      else
        process_partial(@tsg, @config, @make_arg)
      end
      true
    end

    def process_detect(tsg, make_arg)
      array = @tsg.testscripts.map{ |testscript|
        testscript.test_groups.map{ |test_group|
          puts "== test_group"
          puts test_group.name
          puts "  === test_case"
          test_group.test_cases.map{ |test_case|
            puts test_case.name
          }
        }
        puts " ###"
      }
    end

    def process_all(tsg, config, make_arg)
      array = tsg.testscripts.map{ |testscript|
        setting = Erubyx::Setting.new(testscript , config, make_arg)
        setting.setup('tecsgen command')

        setting.output_data_yamlfile
        templatex = Erubyx::Templatex.new(setting)
        templatex.setup
        templatex.output

        [setting, templatex, testscript]
      }
      array.map{|x|
        setting = x[0]
        templatex = x[1]
        testscript = x[2]

        data_yaml_path = setting.data_yaml_path
        if data_yaml_path.file?
          str = Erubyx::Root.new( data_yaml_path , config ).result
          spec_pn = config.make_path_under_script_dir(%!#{testscript.name}_spec.rb!)
          spec_pn.parent.mkdir unless spec_pn.parent.exist?
          File.open(spec_pn.to_s, 'w'){|file|
              file.write(str)
          }
        end
      }
    end

    def process_partial(tsg, config, make_arg)
      array = tsg.testscripts.map{ |testscript|
        setting = Erubyx::Setting.new(testscript , config, make_arg)
        setting.setup("tecsgen command")
        templatex = nil
        [setting, templatex]
      }
      array.map{|x|
        setting = x[0]
        templatex = x[1]
        data_yaml_path = setting.data_yaml_path
        Erubyx::Root.new( data_yaml_path , config ).result
      }
    end
  end
end