# frozen_string_literal: true

require "pathname"
require "fileutils"

module Mkspec
  class Config
    attr_reader :spec_dir_pn, :test_dir_pn, :misc_dir_pn, :output_dir_pn,
                :output_script_dir_pn, :output_template_and_data_dir_pn, :output_test_case_dir_pn,
                :archive_dir_pn

    # spec
    #     /test
    #          /_test_archive
    #     　　　/misc
    # test_output
    # test_output/script
    # test_output/test_case
    # test_output/template_and_data
    #

    def initialize(
      data_top_dir,
      output_data_top_dir,
      output_dir,
      script_dir,

      tad_dir,

      test_case_dir = nil
    )

      # raise unless spec_dir
      #raise unless data_top_dir
      #raise unless output_data_top_dir
      #raise unless output_dir
      # raise unless tad_dir

      @setup_count = 0

      data_top_dir_original = data_top_dir
      @data_top_dir_original_pn = Pathname.new(data_top_dir_original)
      data_top_dir_real_pn = @data_top_dir_original_pn.expand_path
      @data_top_dir_pn = data_top_dir_real_pn

      @output_data_top_dir = ENV.fetch("MKSPEC_OUTPUT_DIR", output_data_top_dir)
      @output_data_top_dir_pn = Pathname.new(@output_data_top_dir)
      @output_test_dir_pn = @output_data_top_dir_pn.join(GlobalConfig::TEST_DIR)
      @test_dir_pn = @data_top_dir_pn.join(GlobalConfig::TEST_DIR)

      @misc_dir_pn = @test_dir_pn.join(GlobalConfig::MISC_DIR)
      @root_output_dir_pn = @data_top_dir_pn.join(GlobalConfig::ROOT_OUTPUT_DIR)

      output_dir_original = output_dir
      output_dir_original_pn = Pathname.new(output_dir_original)
      output_dir_real_pn = output_dir_original_pn.expand_path
      @output_dir = output_dir_real_pn.to_s

      script_dir_original = script_dir
      script_dir_original_pn = Pathname.new(script_dir_original)
      script_dir_real_pn = script_dir_original_pn.expand_path
      @script_dir = script_dir_real_pn.to_s

      if tad_dir.nil?
        @tad_dir = tad_dir
      else
        tad_dir_original = tad_dir
        tad_dir_original_pn = Pathname.new(tad_dir_original)
        tad_dir_real_pn = tad_dir_original_pn.expand_path
        @tad_dir = tad_dir_real_pn.to_s
      end

      if test_case_dir.nil?
        @test_case_dir = test_case_dir
      else
        test_case_dir_original = test_case_dir
        test_case_dir_original_pn = Pathname.new(test_case_dir_original)
        test_case_dir_real_pn = test_case_dir_original_pn.expand_path
        @test_case_dir = test_case_dir_real_pn.to_s
      end

      # script_dir.x
      # ""/home/ykominami/repo/ykominami/mkspec_data/_DATA/hier14"
    end

    def setup
      Loggerxcm.debug("Config.setup 0 #{@setup_count} self=#{self}")
      return self if @setup_count.positive?

      Loggerxcm.debug("Config.setup 1 #{@setup_count} self=#{self}")
      # Loggerxcm.debug(["caller=" , caller].join("\n"))
      output_dir_pn = Pathname.new(@output_dir)
      pn = if output_dir_pn.absolute?
             output_dir_pn
           else
             @root_output_dir_pn.join(@output_dir)
           end
      Loggerxcm.debug("Config.setup pn=#{pn}")
      pn.mkpath unless pn.exist?
      @output_dir_pn = pn
      @script_absolute_dir_pn = check_absolute_dir(@script_dir)
      @tad_absolute_dir_pn = check_absolute_dir(@tad_dir)
      @test_case_absolute_dir_pn = check_absolute_dir(@test_case_dir)
      #@tad_absolute_dir_pn.x = nil
      # @script_absolute_dir_pn.x
      # /home/ykominami/repo/ykominami/mkspec/spec
      @output_script_dir_pn = setup_dir(@script_absolute_dir_pn, @script_dir, @script_dir)

      @output_template_and_data_dir_pn = setup_dir(@tad_absolute_dir_pn, @tad_dir,
                                                   GlobalConfig::OUTPUT_TEMPLATE_AND_DATA_DIR)
      @output_test_case_dir_pn = setup_dir(@test_case_absolute_dir_pn, @test_case_dir,
                                           GlobalConfig::OUTPUT_TEST_CASE_DIR)

      Loggerxcm.debug("Config#setup @test_case_archive_dir_pn=#{@test_case_archive_dir_pn}")
      @test_case_archive_dir_pn = @test_dir_pn.join(GlobalConfig::TEST_CASE_ARCHIVE_DIR)
      if @output_template_and_data_dir_pn.exist?
        Loggerxcm.debug("Config#setup @test_case_archive_dir_pn=#{@test_case_archive_dir_pn} @output_test_case_dir_pn=#{@output_test_case_dir_pn}")
        setup_dir_content(@test_case_archive_dir_pn, @output_test_case_dir_pn)
      else
        Loggerxcm.error("Config#setup Can't find #{@test_case_archive_dir_pn}")
        raise Mkspec::MkspecDebugError, "config.rg 1"
      end

      Loggerxcm.debug("@output_template_and_data_dir_pn=#{@output_template_and_data_dir_pn}")
      @archive_dir_pn = @test_dir_pn.join(GlobalConfig::TEST_ARCHIVE_DIR)
      if archive_dir_pn.exist?
        setup_dir_content(@archive_dir_pn, @output_template_and_data_dir_pn)
      else
        msg = "config.rb 2 #{@archive_dir_pn}"
        Loggerxcm.error("Config#setup Can't find #{@archive_dir_pn} | #{msg}")
        return self
      end
      @setup_count += 1

      self
    end

    def setup_dir(absolute_pn, dir, default_dir)
      if absolute_pn
        absolute_pn
      elsif dir
        Loggerxcm.debug("setup_dir 1 dir=#{dir}")
        setup_directory(dir)
      else
        Loggerxcm.debug("setup_dir 21 dir=#{dir}")
        Loggerxcm.debug("setup_dir 22 default_dir=#{default_dir}")
        setup_directory(default_dir)
      end
    end

    def check_absolute_dir(dir)
      return unless dir

      hash = { given: dir, absolute: nil }
      check_dir(hash)
      hash[:absolute]
    end

    def check_dir(hash)
      given_dir = hash[:given]
      return unless given_dir

      pn = Pathname.new(given_dir)
      hash[:absolute] = pn.absolute? ? pn : pn.realpath if pn.exist?
    end

    def setup_dir_content(src_dir, dest_dir)
      pwd = Dir.pwd
      Loggerxcm.debug("Config#setup_dir_content pwd=#{pwd}")
      Loggerxcm.debug("Config#setup_dir_content src_dir=#{src_dir}")
      Loggerxcm.debug("Config#setup_dir_content dest_dir=#{dest_dir}")
      ret = 0
      begin
        real_src_dir = File.realpath(src_dir)
        Loggerxcm.debug("src_dir=#{src_dir} | real_src_dir=#{real_src_dir}")
        ret += 1
      rescue => exc
        Loggerxcm.fatal(exc)
        Loggerxcm.fatal("Config#setup_dir_content Can't find #{src_dir} pwd=#{pwd}")
      end
      begin
        real_dest_dir = File.realpath(dest_dir)
        Loggerxcm.debug("dest_dir=#{dest_dir} | real_dest_dir=#{real_dest_dir}")
        ret += 1
      rescue => exc
        Loggerxcm.fatal(exc)
      end
      return unless ret >= 2

      FileUtils.cp_r(src_dir, dest_dir)
    end

    def setup_directory(dir)
      pn = @output_dir_pn + dir
      Loggerxcm.debug("setup_directory pn=#{pn}")
      pn.mkpath unless pn.exist?
      pn
    end

    def make_path_under_misc_dir(fname)
      @misc_dir_pn.join(fname)
    end

    def make_path_under_template_and_data_dir(fname)
      @output_template_and_data_dir_pn.join(fname)
    end

    def make_path_under_script_dir(fname)
      @output_script_dir_pn.join(fname)
    end

    def make_path_under_test_case_dir(fname)
      @output_test_case_dir_pn.join(fname)
    end
  end
end
