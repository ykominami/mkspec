# frozen_string_literal: true

require 'pathname'
require 'fileutils'

module Erubyx
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
    SPEC_DIR = 'spec'
    TEST_DIR = 'test'

    TEST_ARCHIVE_DIR = '_test_archive'
    MISC_DIR = 'misc'

#    ROOT_OUTPUT_DIR = 'output'
    ROOT_OUTPUT_DIR = 'test_output'
    OUTPUT_SCRIPT_DIR = 'script'
    OUTPUT_TEST_CASE_DIR = 'test_case'
    OUTPUT_TEMPLATE_AND_DATA_DIR = 'template_and_data'

    def initialize(spec_dir, output_dir, test_case_dir = nil)
      @setup_count = 0
      @spec_dir_pn = Pathname.new(spec_dir)

      @test_dir_pn = @spec_dir_pn + TEST_DIR

      @misc_dir_pn = @test_dir_pn + MISC_DIR
      top_pn = @spec_dir_pn + ".."
      @root_output_dir_pn = top_pn + ROOT_OUTPUT_DIR
      @output_dir = output_dir
      @test_case_dir = test_case_dir
    end

    def setup
      return self if @setup_count > 0
      pn = @root_output_dir_pn + @output_dir
      pn.mkpath unless pn.exist?
      @output_dir_pn = pn

      @output_template_and_data_dir_pn = setup_directory(OUTPUT_TEMPLATE_AND_DATA_DIR)
      @output_script_dir_pn = setup_directory(OUTPUT_SCRIPT_DIR)
      if @test_case_dir
        pn = Pathname.new(@test_case_dir)
        pn.mkpath unless pn.exist?
        @output_test_case_dir_pn = pn
      else
        @output_test_case_dir_pn = setup_directory(OUTPUT_TEST_CASE_DIR)
      end

      @archive_dir_pn = @test_dir_pn + TEST_ARCHIVE_DIR
      setup_archive_dir
      @setup_count += 1

      self
    end

    def initialize_0(spec_dir, output_dir, test_case_dir = nil)
      @spec_dir_pn = Pathname.new(spec_dir)

      @test_dir_pn = @spec_dir_pn + TEST_DIR

      @misc_dir_pn = @test_dir_pn + MISC_DIR
      top_pn = @spec_dir_pn + ".."
      @root_output_dir_pn = top_pn + ROOT_OUTPUT_DIR

      pn = @root_output_dir_pn + output_dir
      pn.mkpath unless pn.exist?
      @output_dir_pn = pn

      @output_template_and_data_dir_pn = setup_directory(OUTPUT_TEMPLATE_AND_DATA_DIR)
      @output_script_dir_pn = setup_directory(OUTPUT_SCRIPT_DIR)
      if test_case_dir
        pn = Pathname.new(test_case_dir)
        pn.mkpath unless pn.exist?
        @output_test_case_dir_pn = pn
      else
        @output_test_case_dir_pn = setup_directory(OUTPUT_TEST_CASE_DIR)
      end

      @archive_dir_pn = @test_dir_pn + TEST_ARCHIVE_DIR
      setup_archive_dir
    end

    def setup_archive_dir
      FileUtils.copy_entry(@archive_dir_pn, @output_template_and_data_dir_pn) if @archive_dir_pn.exist?
    end

    def setup_directory(dir)
      pn = @output_dir_pn + dir
      pn.mkpath unless pn.exist?
      pn
    end

    def make_path_under_misc_dir(fname)
      @misc_dir_pn + fname
    end

    def make_path_under_template_and_data_dir(fname)
      @output_template_and_data_dir_pn + fname
    end

    def make_path_under_script_dir(fname)
      @output_script_dir_pn + fname
    end

    def make_path_under_test_case_dir(fname)
      @output_test_case_dir_pn + fname
    end
  end
end
