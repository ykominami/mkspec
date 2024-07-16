# frozen_string_literal: true

require 'pathname'
require 'yaml'

module Mkspec
  # The `Mkspec::Root` class serves as the entry point for managing the root configuration and settings within the Mkspec framework.
  # It is responsible for initializing the framework's configuration by loading and validating settings from a specified YAML file.
  # This class plays a crucial role in setting up the environment for the Mkspec framework by ensuring that all necessary
  # configurations are correctly loaded and accessible. It also provides methods for extracting and managing specific
  # configuration details, facilitating the dynamic creation and manipulation of items based on the framework's settings.
  #
  # @example Initializing a new `Root` instance with a YAML configuration file
  #   root = Mkspec::Root.new("config.yml", config)
  #
  # @param yml_fname [String] The filename of the YAML file containing configuration settings.
  # @param config [Mkspec::Config] An instance of the `Mkspec::Config` class for managing framework configurations.
  class Root
    def initialize(yml_fname, config)
      yml_0_pn = Pathname.new(yml_fname)
      basename = yml_0_pn.basename
      yml_pn = yml_0_pn.exist? ? yml_0_pn : config.make_path_under_misc_dir(basename)
      raise Mkspec::MkspecDebugError, "root.rb initialize yml_0_pn=#{yml_0_pn} yml_pn=#{yml_pn}" unless yml_pn.exist?

      Loggerxcm.debug("Root.initialize yml_pn=#{yml_pn}")
      @setting_hash = Util.extract_in_yaml_file(yml_pn)
      unless Util.validate_hash(@setting_hash, "top_dir", String)
        Loggerxcm.debug("Root.initialize @setting_hash=#{@setting_hash}")
        raise Mkspec::MkspecDebugError, "root.rb initialize 1"
      end
      @content_path = @setting_hash['path']
      raise Mkspec::MkspecDebugError, "root.rb 1 @contnet_path=#{@content_path}" unless @content_path

      @config = config
      @content_pn = @config.make_path_under_template_and_data_dir(@content_path)
      @level = 1
    end

    def extract_in_hash_with_setting_hash(hash)
      @setting_hash.each do |k, v|
        if v.instance_of?(Hash)
          content_path = v['path']
          raise Mkspec::MkspecDebugError, "root.rb extract_in_hash_with_setting_hash 1" unless Util.validate_hash(v, "top_dir", String)

          yaml_path = nil
          Loggerxcm.debug("Root#extract_in_hash_with_setting_hash content_path=#{content_path}")
          item = Item.new(@level, 0, k, v, content_path, yaml_path, @config)
          hash[k] = item.result
        else
          hash[k] = v
        end
      end
    end

    def make_item(hash)
      extract_in_hash_with_setting_hash(hash)
      yaml_path = nil
      Item.new(@level, 0, :root, hash, @content_pn, yaml_path, @config)
    end

    def result
      hash = {}
      item = make_item(hash)
      content = item.result
      if Util.not_empty_string?(content).first
        ret = Util.extract_with_eruby(content)
        Loggerxcm.debug("Root#result 4")
        ret
      else
        Loggerxcm.debug("Root#result 5")
        nil
      end
    end
  end
end
