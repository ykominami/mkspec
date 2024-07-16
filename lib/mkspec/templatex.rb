# frozen_string_literal: true

require 'pathname'

module Mkspec
  # The `Templatex` class is responsible for generating and managing templates within the Mkspec framework.
  # It utilizes settings and configurations to dynamically create templates based on predefined structures
  # and user-defined parameters. This class plays a crucial role in the generation of test scripts and other
  # automated tasks by providing a flexible and efficient way to produce customized content.
  class Templatex
    # Initializes a new instance of the Templatex class with the necessary settings and configuration.
    # It sets up the template path and ensures the directory exists, preparing for template generation.
    # @param setting [Mkspec::Setting] The settings object containing configuration details.
    # @param config [Mkspec::Config] The configuration object for additional parameters.
    def initialize(setting, config)
      @setting = setting
      @config = config
      @template_path = @setting.template_path
      pn = Pathname.new(@template_path)
      pn.parent.mkdir unless pn.parent.exist?
      @content = ""
      @func_name_of_make_arg = @setting.func_name_of_make_arg
    end

    # Generates a line of template content with one level of indentation.
    # @param name [String] The name to be included in the template line.
    # @return [String] The generated template line.
    def make_line_1(name)
      %(  <%= #{name} %>)
    end

    # Generates a line of template content with two levels of indentation.
    # @param name [String] The name to be included in the template line.
    # @return [String] The generated template line.
    def make_line_2(name)
      %(    <%= #{name} %>)
    end

    # Sets up the template content by reading and processing predefined parts and dynamically generated sections.
    # It constructs the template based on the test script structure and additional parameters.
    # @return [Boolean] Always returns true, indicating the setup process was executed.
    def setup
      ret = true
      lines = []
      pn = Pathname.new("#{GlobalConfig::TEST_ARCHIVE_DIR}/rspec_head/content.txt")

      str = Util.get_file_content(@config.make_path_under_template_and_data_dir(pn))
      lines << str

      @setting.testscript.test_groups.each do |test_group|
        lines << make_line_1(test_group.name)
        lines << make_line_2(test_group.content_name_of_make_arg)
        test_group.test_cases.each do |test_case|
          lines << make_line_2(test_case.extra) if test_case.extra
          lines << make_line_2(test_case.name)
        end
        lines << "  <%= rspec_describe_context_end %>"
      end
      str_end = "<%= rspec_describe_end %>"
      lines << str_end

      @content = lines.join("\n")
      ret
    end

    # Outputs the generated template content to the specified file path.
    # It writes the content to a file and handles any potential errors during the process.
    # @raise [Mkspec::MkspecDebugError] Raises an error if writing to the file fails.
    # @return [Boolean] Returns true if the content was successfully written, false otherwise.
    def output
      ret = true
      begin
        File.write(@template_path, @content)
      rescue StandardError => exc
        message = [
          exc.message,
          exc.backtrace
        ]
        Loggerxcm.error(message)
        ret = false
      end
      raise Mkspec::MkspecDebugError, "templatex.rb 1 ret=#{ret}" unless ret

      ret
    end
  end
end
