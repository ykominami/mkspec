module Erubyx
  class Mkscript
    #def initialize(dir, data_top_dir, fname, start_char, limit, make_arg)
    #end

    def initialize
      # test_data_dir
      #   data
      #   script
      #   setting
      #   test_case
      #
      test_data_dir =  '.'
      case ARGV.size
      when 0
        show_useage_and_exit
      when 1
        show_useage_and_exit
      when 2
        if ARGV[0] == "-d"
          @test_data_dir = ARGV[1]
          ARGV.shift
          ARGV.shift
        end
      end

      case ARGV.size
        when 0
          show_useage_and_exit
        when 1
          show_useage_and_exit
        when 2
          @tsv_fname = ARGV[0]
          ARGV.shift
          @yaml_fname = ARGV[0]
          ARGV.shift
        end
      end
      @otput_dir = "."
      @opt = "detect"
      case ARGV.size
      when 0
        show_useage_and_exit
      when 1
        @output_dir = ARGV[0]
      when 2
        @otput_dir = ARGV[0]
        @opt = ARGV[1]
      else
        opt = "all"
      end

      puts "tsv_fname=#{tsv_fname}"
      puts "yaml_fname=#{@yaml_fname}"
      puts "test_data_dir=#{@test_data_dir}"
      puts "output_dir=#{@output_dir}"
      puts "opt=#{@opt}"
      #exit 0

      start_char = 'f'
      limit = 6
      @make_arg = Erubyx::MAKE_ARG

      @test_data_dir_pn = Pathname.new(test_data_dir)
      @tsv_path = test_data_dir_pn + tsv_fname
      @tsg = Erubyx::TestScriptGroup.new( tsv_path, start_char, limit, make_arg )
      @tsg.setup
    end
=begin
    def show_useage_and_exit
      puts "make_scra [-d dir] tsv_fname yaml_fname [output_dir] [opt]"
      exit 10
    end

    def do_process
      if @opt == "all"
        puts "mode: all"
        process_all(@tsg, @data_top_dir, @make_arg, @dir)
      elsif @opt == "detect"
        puts "mode: detect"
        process_detect(@tsg, @data_top_dir, @make_arg)
      else
        puts "mode: partial"
      #  process_partial(tsg, data_top_dir, make_arg)
        process_partial_1(@tsg, @data_top_dir, @make_arg)
      end
    end

    def process_detect(tsg, data_top_dir, make_arg)
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

    def process_all(tsg, data_top_dir, make_arg, output_dir = ".")
      array = tsg.testscripts.map{ |testscript|
        setting = Erubyx::Setting.new(testscript , data_top_dir, make_arg)
        setting.setup

        setting.output_yaml
        templatex = Erubyx::Templatex.new(setting)
        templatex.setup
        templatex.output

        [setting, templatex, testscript]
      }
      array.map{|x|
        setting = x[0]
        templatex = x[1]
        testscript = x[2]

        yml_fname = setting.yaml_path
        str = Erubyx::Root.new( yml_fname , data_top_dir ).result
        pn = Pathname.new(output_dir)
        pn.mkdir unless pn.exist?
        pn = pn + %!#{testscript.name}_rspec.rb!
        File.open(pn.to_s, 'w'){|file|
            file.write(str)
        }
      }
    end

    def process_partial_1(tsg, data_top_dir, make_arg)
      testscript = tsg.testscripts[0]
      setting = Erubyx::Setting.new(testscript , data_top_dir, make_arg)
      setting.setup
      templatex = nil

      yml_fname = setting.yaml_path
      str = Erubyx::Root.new( yml_fname , data_top_dir ).result
    end

    def process_partial(tsg, data_top_dir, make_arg)
      array = tsg.testscripts.map{ |testscript|
        setting = Erubyx::Setting.new(testscript , data_top_dir, make_arg)
        setting.setup
        templatex = nil
        [setting, templatex]
      }
      array.map{|x|
        setting = x[0]
        templatex = x[1]
        yml_fname = setting.yaml_path
        str = Erubyx::Root.new( yml_fname , data_top_dir ).result
      }
    end
=end
  end
end