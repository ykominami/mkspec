# frozen_string_literal: true
module Erubyx
  class Mkspec
    def print_debug
      puts "yaml_fname=#{@yaml_fname}"
      puts "test_data_dir=#{@test_data_dir}"
    end

    def show_usage_and_exit(o, message)
      puts message
      puts o.banner
      exit Erubyx::EXIT_CODE_OF_CMDLINE_OPTION_ERROR
    end

    def initialize
      p ARGV
      @cmd = "detect"
      ARGV.options do |o|
        o.banner = "ruby $0 -d dir -y  yaml_fname"
        o.on('-d dir', 'test data directory'){|x| @test_data_dir = x}
        o.on('-y yaml', 'yaml file'){|x| @yaml_fname = x}

        o.parse!
      end
      p ARGV.inspect
      print_debug

      unless @test_data_dir
        show_usage_and_exit(ARGV.options, "1")
      end
      unless @yaml_fname
        show_usage_and_exit(ARGV.options, "2")
      end
      yml_fname = ARGV[0]
      #data_top_dir = "./hier"
      @config = Config.new( @test_data_dir )

      str = Erubyx::Root.new( yml_fname , config ).result
      puts "<<<"
      puts str
    end
  end
end