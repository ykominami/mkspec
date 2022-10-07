# frozen_string_literal: true

module Mkspec
  require 'yaml'

  class Root
    def initialize(yml_fname, config)
      yml_pn = Pathname.new(yml_fname)
      yml_pn = config.make_path_under_misc_dir(yml_pn) unless yml_pn.exist?
      # puts "root.rb Root.initialize yml_pn=#{yml_pn}"
      raise( Mkspec::MkspecDebugError, "root.rb initialize yml_pn=#{yml_pn}") unless yml_pn.exist?

      Loggerxcm.debug("Util.extract_in_yaml_file yml_pn=#{yml_pn}")
      @setting_hash = Util.extract_in_yaml_file(yml_pn)
      unless Util.validate_hash(@setting_hash, "top_dir", String)
        Loggerxcm.debug("Root#initialize @setting_hash=#{@setting_hash}")
        raise(Mkspec::MkspecDebugError, "root.rb initialize 1")
      end
      @content_path = @setting_hash['path']
      raise(Mkspec::MkspecDebugError, "root.rb 1 @contnet_path=#{@content_path}") unless @content_path

      @config = config
      @content_pn = @config.make_path_under_template_and_data_dir(@content_path)
      @level = 1
    end

    def extract_in_hash_with_setting_hash(hash)
      @setting_hash.each do |k, v|
        if v.instance_of?(Hash)
          content_path = v['path']
          raise(Mkspec::MkspecDebugError, "root.rb extract_in_hash_with_setting_hash 1") unless Util.validate_hash(v,
                                                                                                                   "top_dir", String)

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
      ret = nil
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
