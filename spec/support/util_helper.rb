require 'pathname'

module UtilHelper
  
  def self.make_args( test_data_dir, target_parent_dir , num , tecsgen_name, result_name , script_path, *param_name )
    target_dir = Pathname.new(target_parent_dir) + num.to_s
    result = Pathname.new(target_dir) + result_name
    list = param_name.join(" ")

    "#{script_path} #{test_data_dir} #{result} #{tecsgen_name} #{target_dir} #{list}"
  end

  class Conf
    attr_reader :cmd_path
    
    def initialize(top_dir, test_data_dir, test_case_dir, tecsgen, tecsmerge, cmd_path)
      @top_dir = Pathname.new( top_dir )
      @test_data_dir = Pathname.new( test_data_dir )
      @test_case_dir = Pathname.new( test_case_dir )
      @tecsgen = tecsgen
      @tecsmerge = tecsmerge
      @cmd_path = Pathname.new( cmd_path )
    end

    def make_target_dir( target_parent_dir , num )
      ret = ""
      if target_parent_dir
        if num
          ret =target_parent_dir + num.to_s
        else
          ret = target_parent_dir
        end
      else
        if num
          ret = num.to_s
        end
      end

      ret
    end
    
    def make_result_file_path( target_dir , result )
      ret = ""
      if target_dir
        if result
          ret = target_dir + result.to_s
        else
          ret = target_dir
        end
      else
        if result
          ret = result
        end
      end

      ret
    end

    def make_target_dir_and_result_file_path( target_parent_dir , num , result )
      target_dir = make_target_dir( target_parent_dir , num )
      result_file_path = make_result_file_path( target_dir , result )

      [target_dir , result_file_path]
    end
    
    def make_args( target_dir, result, optx, *param_name )
      params = param_name.join(" ")

      "#{@cmd_path} #{@test_data_dir} #{result} #{@tecsgen} #{target_dir} #{optx} #{params}"
    end

    def get_relative_path_base( target_dir , base_dir = nil)
      if base_dir
        base_pn = Pathname.new(base_dir)

        target_pn = Pathname.new(target_dir)
        if target_pn.exist?
          relative_pn = target_pn.relative_path_from(base_pn)
        else
          relative_pn = target_pn
        end
      else
        relative_pn = Pathname.new(target_dir)
      end
      relative_pn
    end
    
    def get_relative_path(target_top_dir, target_sub_dir , base_dir = nil)
      target_top_pn = Pathname.new(target_top_dir)
      target_pn = target_top_pn + target_sub_dir
      get_relative_path_base( target_pn , base_dir )
    end
    
    def make_include_path_option( include_path , current_path = nil)
      relative_pn = get_relative_path( @test_data_dir, include_path , current_path)
      %!-I #{relative_pn}!
    end

    def make_include_path_option_list_of_under_RUNTIME_directory(target_dir)
      make_include_path_option_list_of_under_RUNTIME_tecs_runtime_directory(target_dir) +
        make_include_path_option_list_of_under_RUNTIME_runtime_directory(target_dir)
    end

    def make_include_path_option_list_of_under_RUNTIME_tecs_runtime_directory(target_dir)
      %W!
      #{make_include_path_option( "RUNTIME/tecs-runtime/include" , target_dir )}
      #{make_include_path_option( "RUNTIME/tecs-runtime/target" , target_dir )}
      !
    end

    def make_include_path_option_list_of_under_RUNTIME_runtime_directory(target_dir)
      %W!
      #{make_include_path_option( "RUNTIME/runtime/include" , target_dir )}
      #{make_include_path_option( "RUNTIME/runtime/target" , target_dir )}
      !
    end

    def make_include_path_option_list_of_cygwin_directory(target_dir)
      %W!
      #{make_include_path_option( "cygwin" , target_dir )}
      !
    end

    def make_include_path_option_list_of_cygwin3_directory(target_dir)
      %W!
      #{make_include_path_option( "cygwin3" , target_dir )}
      !
    end

    def make_include_path_option_list_of_src_directory(target_dir)
      %W!
      #{make_include_path_option( "src" , target_dir )}
      !
    end

    def make_include_path_option_from_TECSPATH(target_dir)
      %W!
      #{make_include_path_option( ENV['TECSPATH'] , target_dir )}
      !
    end

    def make_include_path_option_list_of_under_TECSPATH_directory
      %W!
      #{make_include_path_option( "mruby" , ENV['TECSPATH'] )}
      #{make_include_path_option( "posix" , ENV['TECSPATH'] )}
      #{make_include_path_option( "rpc"   , ENV['TECSPATH'] )}
      !
    end

    def make_include_path_option_simple(path)
      [ %!-I #{path}! ]
    end

    def make_gen_option(val)
      %!--gen=#{val}!
    end

    def make_debug_option_y()
      #tecsgen  -I ../cygwin
      # -I /home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecs
      # -I ../RUNTIME/runtime/include -I ../RUNTIME/runtime/test
      # -I src --gen=gen_comp composite.cdl
      %!-y!
    end

    def make_debug_option_t()
      #tecsgen  -I ../cygwin
      # -I /home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecs
      # -I ../RUNTIME/runtime/include -I ../RUNTIME/runtime/test
      # -I src --gen=gen_comp composite.cdl
      %!-t!
    end

    def make_generate_region(path)
      if path == :null_string
        %q!-G \"\"!
      else
        %!-G #{path}!
      end
    end

    def make_library_path(path)
      %!-L #{path}!
    end

    def make_ram_initializer_option
      %!-R!
    end

    def make_ram_only_option
      %!-r!
    end

    def make_uniq_id_option
      %!-u!
    end

    def make_idx_is_id_option
      %!-i!
    end
  end

  def self.set_conf(top_dir, test_data_dir, test_case_dir, tecsgen, tecsmerge, cmd_path)
    Conf.new(top_dir, test_data_dir, test_case_dir, tecsgen, tecsmerge, cmd_path)
  end
end
