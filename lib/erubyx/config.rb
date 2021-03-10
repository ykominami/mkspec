# frozen_string_literal: true
require 'pathname'
require 'fileutils'

module Erubyx
    class Config
        DATA_DIR = "data"
        SCRIPT_DIR = "script"
        SETTING_DIR = "setting"
        TEST_CASE_DIR = "test_case"

        def setup_archive_dir
            if @archive_pn.exist?
#                @archive_pn.each_child do |x|
                    puts "@archive_pn=#{@archive_pn}"
                    puts " @test_data_data_dir_pn=#{@test_data_data_dir_pn}"
                    FileUtils.copy_entry( @archive_pn , @test_data_data_dir_pn )
#                end
            end
        end

        def initialize(test_data_dir , spec_dir)
            pn = Pathname.new(test_data_dir)
            pn.mkpath unless pn.exist?
            @test_data_dir_pn = pn
            @test_data_setting_dir_pn = setup_directory(SETTING_DIR)
            @test_data_data_dir_pn = setup_directory(DATA_DIR)
            @test_data_script_dir_pn = setup_directory(SCRIPT_DIR)
            @test_data_test_case_dir_pn = setup_directory(DATA_DIR)

            puts "spec_dir=#{spec_dir}"
            @spec_pn = Pathname.new(spec_dir)
            puts "@spec_pn=#{@spec_pn}"
            @archive_pn = @spec_pn + "test_data" + "_test_archive"
            setup_archive_dir
        end

        def setup_directory(dir)
            pn = @test_data_dir_pn + dir
            pn.mkpath unless pn.exist?
            pn
        end

        def make_path_under_setting_dir(fname)
            @test_data_setting_dir_pn ||= setup_directory(SETTING_DIR)
            @test_data_setting_dir_pn + fname
        end

        def make_path_under_data_dir(fname)
            @test_data_data_dir_pn ||= setup_directory(SETTING_DIR)
            @test_data_data_dir_pn + fname
        end

        def make_path_under_script_dir(fname)
            @test_data_script_dir_pn ||= setup_directory(SCRIPT_DIR)
            @test_data_script_dir_pn + fname
        end

        def make_path_under_test_case_dir(fname)
            @test_data_test_case_dir_pn ||= setup_directory(TEST_CASE_DIR)
            @test_data_test_case_dir_pn + fname
        end
    end
end