# frozen_string_literal: true

require 'pathname'
require 'clitest'

module UtilHelper
  def self.make_args(test_data_dir, target_parent_dir, num, _cmd_for_test, result_name, script_path, *param_name)
    target_dir = Pathname.new(target_parent_dir) + num.to_s
    result = Pathname.new(target_dir) + result_name
    list = param_name.join(' ')

    "#{script_path} #{test_data_dir} #{result} #{cmd_fortest} #{target_dir} #{list}"
  end

  def self.make_conf(config, test_cmd, target_cmd_1, target_cmd_2)
    Conf.new(config, test_cmd, target_cmd_1, target_cmd_2)
  end

  def self.make_conf_0(top_dir, output_dir, test_case_dir, test_cmd, target_cmd_1, target_cmd_2)
    Conf.new(top_dir, output_dir, test_case_dir, test_cmd, target_cmd_1, target_cmd_2)
  end

  class Conf
    attr_reader :test_cmd_path
    def initialize(config, test_cmd, target_cmd_1, target_cmd_2)
      @config = config
    end

    def initialize_0(top_dir, test_data_dir, test_case_dir, test_cmd, target_cmd_1, target_cmd_2)
      @top_dir_pn = Pathname.new(top_dir)
      @test_data_dir_pn = Pathname.new(test_data_dir)
      @test_case_dir_pn = Pathname.new(test_case_dir)
      @target_cmd_1 = target_cmd_1
      @target_cmd_2 = target_cmd_2
      @current_pn = Pathname.new(Dir.pwd)
      @test_cmd_path_pn = @current_pn + bin + test_cmd
      unless @test_cmd_path_pn.exist?
        @test_cmd_path_pn = @current_pn + specbi + test_cmd
        @test_cmd_path_pn = find_cmd(@current_pn, test_cmd) unless @test_cmd_path_pn.exist?
      end
      unless @test_cmd_path_pn
        # puts "@test_cmd_path_pn=#{@test_cmd_path_pn}"
        raise
      end
    end

    def make_cmdline_base(target_cmd, target_dir, result, optx, *param_names)
      params = param_names.join(' ')

      "#{@test_cmd_path_pn} #{@test_data_dir_pn} #{result} #{target_cmd} #{target_dir} #{optx} #{params}"
    end

    def make_cmdline_1(target_dir, result, optx, *param_names)
      make_cmdline_base(@target_cmd_1, target_dir, result, optx, *param_names)
    end

    def make_cmdline_2(target_dir, result, optx, *_param_name)
      make_cmdline_base(@target_cmd_2, target_dir, result, optx, *param_names)
    end

    def find_cmd(start_dir, cmd)
      ret = [false, nil]
      pn = Pathname.new(start_dir)
      while ret[0] == false
        cmd_pn = pn + cmd
        if cmd_pn.exist?
          ret = [true, cmd_pn]
        else
          cmd_pn = "#{pn}bin#{cmd}"
          ret = [true, cmd_pn] if cmd_pn.exist?
        end
        if ret[0] == false
          if pn == pn.parent
            ret = [true, nil]
          else
            pn = pn.parent
          end
        end
      end
      ret[1]
    end

    def make_target_dir(target_parent_dir, num)
      ret = ''
      if target_parent_dir
        target_parent_pn = Pathname.new(target_parent_dir)
        ret = if num
                target_parent_pn + num.to_s
              else
                target_parent_pn
              end
      elsif num
        ret = Pathname.new(num.to_s)
      end

      ret.to_s
    end

    def make_result_file_path(target_dir, result)
      ret = ''
      if target_dir
        target_pn = Pathname.new(target_dir)
        ret = if result
                target_pn + result
              else
                target_pn
              end
      elsif result
        result_pn = Pathname.new(result)
        ret = result_pn
      end

      ret.to_s
    end

    def make_target_dir_and_result_file_path(target_parent_dir, num, result)
      target_dir = make_target_dir(target_parent_dir, num)
      result_file_path = make_result_file_path(target_dir, result)

      [target_dir, result_file_path]
    end

    def get_relative_path_base(target_dir, base_dir = nil)
      if base_dir
        base_pn = Pathname.new(base_dir)

        target_pn = Pathname.new(target_dir)
        relative_pn = if target_pn.exist?
                        target_pn.relative_path_from(base_pn)
                      else
                        target_pn
                      end
      else
        relative_pn = Pathname.new(target_dir)
      end
      relative_pn
    end

    def get_relative_path(target_top_dir, target_sub_dir, base_dir = nil)
      target_top_pn = Pathname.new(target_top_dir)
      target_pn = target_top_pn + target_sub_dir
      get_relative_path_base(target_pn, base_dir)
    end

    def make_include_path_option(include_path, current_path = nil)
      relative_pn = get_relative_path(@test_data_dir, include_path, current_path)
      %(-I #{relative_pn})
    end

    def make_include_path_option_list_of_under_RUNTIME_directory(target_dir)
      make_include_path_option_list_of_under_RUNTIME_tecs_runtime_directory(target_dir) +
        make_include_path_option_list_of_under_RUNTIME_runtime_directory(target_dir)
    end

    def make_include_path_option_list_of_under_RUNTIME_tecs_runtime_directory(target_dir)
      %W[
        #{make_include_path_option('RUNTIME/tecs-runtime/include', target_dir)}
        #{make_include_path_option('RUNTIME/tecs-runtime/target', target_dir)}
      ]
    end

    def make_include_path_option_list_of_under_RUNTIME_runtime_directory(target_dir)
      %W[
        #{make_include_path_option('RUNTIME/runtime/include', target_dir)}
        #{make_include_path_option('RUNTIME/runtime/target', target_dir)}
      ]
    end

    def make_include_path_option_list_of_cygwin_directory(target_dir)
      %W[
        #{make_include_path_option('cygwin', target_dir)}
      ]
    end

    def make_include_path_option_list_of_cygwin3_directory(target_dir)
      %W[
        #{make_include_path_option('cygwin3', target_dir)}
      ]
    end

    def make_include_path_option_list_of_src_directory(target_dir)
      %W[
        #{make_include_path_option('src', target_dir)}
      ]
    end

    def make_include_path_option_from_TECSPATH(target_dir)
      %W[
        #{make_include_path_option(ENV['TECSPATH'], target_dir)}
      ]
    end

    def make_include_path_option_list_of_under_TECSPATH_directory
      %W[
        #{make_include_path_option('mruby', ENV['TECSPATH'])}
        #{make_include_path_option('posix', ENV['TECSPATH'])}
        #{make_include_path_option('rpc', ENV['TECSPATH'])}
      ]
    end

    def make_include_path_option_simple(path)
      [%(-I #{path})]
    end

    def make_gen_option(val)
      %(--gen=#{val})
    end

    def make_debug_option_y
      # tecsgen  -I ../cygwin
      # -I /home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecs
      # -I ../RUNTIME/runtime/include -I ../RUNTIME/runtime/test
      # -I src --gen=gen_comp composite.cdl
      %(-y)
    end

    def make_debug_option_t
      # tecsgen  -I ../cygwin
      # -I /home/ykominami/repo/ns3-tecsgen/tecsgen/tecsgen/tecs
      # -I ../RUNTIME/runtime/include -I ../RUNTIME/runtime/test
      # -I src --gen=gen_comp composite.cdl
      %(-t)
    end

    def make_generate_region(path)
      if path == :null_string
        %q(-G \"\")
      else
        %(-G #{path})
      end
    end

    def make_library_path(path)
      %(-L #{path})
    end

    def make_ram_initializer_option
      %(-R)
    end

    def make_ram_only_option
      %(-r)
    end

    def make_uniq_id_option
      %(-u)
    end

    def make_idx_is_id_option
      %(-i)
    end
  end
end
