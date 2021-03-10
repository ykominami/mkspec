# frozen_string_literal: true
module Erubyx
  class Mkscript
    #def initialize(dir, data_top_dir, fname, start_char, limit, make_arg)
    #end
    require 'optparse'

    def print_debug
      puts "tsv_fname=#{@tsv_fname}"
      puts "test_data_dir=#{@test_data_dir}"
      puts "cmd=#{@cmd}"
    end

    def show_usage_and_exit(o, message)
      puts message
      puts o.banner
      exit Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
    end

    def initialize
      p ARGV
      bin_pn = Pathname.new(__FILE__)
      p bin_pn
      p bin_pn.parent
      p bin_pn.parent.parent.parent
      pn = bin_pn.parent.parent.parent + "spec"
      p pn
      if pn.exist?
        puts "pn.exist"
        @spec_pn = pn
      end
      p "spec_pn=#{@spec_pn}"

      @cmd = "detect"
      p "B @cmd=#{@cmd}"
      ARGV.options do |o|
        o.banner = "ruby $0 -d dir -y  yaml_fname -t tsv_fname -o [output_dir] -c [detect|all|partial] "
        o.on('-d dir', 'test data directory'){|x| @test_data_dir = x}
        o.on('-t tsv', 'tsv file'){|x| @tsv_fname = x}
        o.on('-c cmd', 'command'){|x| @cmd = x}
        o.parse!
      end
      p ARGV.inspect
      print_debug

      p "A @cmd=#{@cmd}"
      unless @test_data_dir
        show_usage_and_exit(ARGV.options, "1")
      end
      unless @tsv_fname
        show_usage_and_exit(ARGV.options, "3")
      end
      unless @cmd
        show_usage_and_exit(ARGV.options, "5")
      end

      start_char = 'f'
      limit = 6
      @make_arg = Erubyx::MAKE_ARG

      @test_data_dir_pn = Pathname.new(@test_data_dir)
      @tsv_path = Pathname.new(@tsv_fname)

      puts "@tsv_path=#{@tsv_path}"
      unless @tsv_path.exist?
        @tsv_path = @config.make_path_under_setting_dir( @tsv_fname )
        puts "1"
      else
        puts "2"
        puts "@tsv_path=#{@tsv_path}"
      end

      @config = Config.new( @test_data_dir , @spec_pn )

      @tsg = Erubyx::TestScriptGroup.new( @tsv_path, start_char, limit, @make_arg )
      @tsg.setup
    end

    def do_process
      if @cmd == "all"
        puts "mode: all"
        process_all(@tsg, @config, @make_arg)
      elsif @cmd == "detect"
        puts "mode: detect"
        process_detect(@tsg, @make_arg)
      else
        puts "mode: partial"
      #  process_partial(tsg, data_top_dir, make_arg)
#        process_partial_1(@tsg, @config, @make_arg)
        process_partial(@tsg, @config, @make_arg)
      end
    end

    def process_detect(tsg, make_arg)
      array = @tsg.testscripts.map{ |testscript|
        puts testscript.name
        puts testscript.script_name
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
#        binding.pry
          str = Erubyx::Root.new( data_yaml_path , config ).result
          spec_pn = config.make_path_under_script_dir(%!#{testscript.name}_spec.rb!)
          spec_pn.parent.mkdir unless spec_pn.parent.exist?
          File.open(spec_pn.to_s, 'w'){|file|
              file.write(str)
          }
        else
          puts "[D] #{data_yaml_path}"
        end
      }
    end

    def process_partial_1(tsg, config, make_arg)
      testscript = tsg.testscripts[0]
      setting = Erubyx::Setting.new(testscript , config, make_arg)
      setting.setup("tecsgen command")

      data_yaml_path = setting.yaml_path
      str = Erubyx::Root.new( data_yaml_path , config ).result
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
        str = Erubyx::Root.new( data_yaml_path , config ).result
      }
    end
  end
end