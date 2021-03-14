# frozen_string_literal: true
require 'pathname'
require 'fileutils'

module Erubyx
  module X
  end

  class Config
    # spec
    #     /_test_archive
    #     /misc

    #     /output
    #     /output/script
    #     /output/test_case
    #     /output/template_and_data
    #     /output/setting
    #
    TEST_DIR = 'test'
    TEST_ARCHIVE_DIR = '_test_archive'
    MISC_DIR = 'misc'

    ROOT_OUTPUT_DIR = 'output'
    OUTPUT_SCRIPT_DIR = 'script'
    OUTPUT_TEST_CASE_DIR = 'test_case'
    OUTPUT_TEMPLATE_AND_DATA_DIR = 'template_and_data'

    def initialize(output_dir, test_case_dir = nil)
      @spec_pn = get_spec_pn
      @test_dir_pn = @spec_pn + TEST_DIR

      @misc_dir_pn = @test_dir_pn + MISC_DIR
      @root_output_dir_pn = @test_dir_pn + ROOT_OUTPUT_DIR

      pn = @root_output_dir_pn + output_dir
      pn.mkpath unless pn.exist?
      @output_dir_pn = pn

      @output_template_and_data_dir_pn = setup_directory(OUTPUT_TEMPLATE_AND_DATA_DIR)
      @output_script_dir_pn = setup_directory(OUTPUT_SCRIPT_DIR)
      unless test_case_dir
        @output_test_case_dir_pn = setup_directory(OUTPUT_TEST_CASE_DIR)
      else
        pn = Pathname.new(test_case_dir)
        pn.mkpath unless pn.exist?
        @output_test_case_dir_pn = pn
      end

      @archive_dir_pn = @test_dir_pn + TEST_ARCHIVE_DIR
      setup_archive_dir
    end

    def setup_archive_dir
      if @archive_dir_pn.exist?
        FileUtils.copy_entry(@archive_dir_pn, @output_template_and_data_dir_pn)
      end
    end

    def get_spec_pn
      pn = Pathname.new(__FILE__).parent.parent.parent + "spec"
      if pn.exist?
        @spec_pn = pn
      end
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
