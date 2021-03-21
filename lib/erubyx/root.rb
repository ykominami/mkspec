# frozen_string_literal: true

module Erubyx
  require 'yaml'

  class Root
    def initialize(yml_fname, config)

      yml_pn = Pathname.new(yml_fname)
      yml_pn = config.make_path_under_misc_dir(yml_pn) if yml_pn.exist?
      Loggerxcm.debug("yaml_lod yml_pn=#{yml_pn}")
      @setting_hash = YAML.load_file(yml_pn)
      @content_path = @setting_hash['path']
      @config = config
      @content_pn = @config.make_path_under_template_and_data_dir(@content_path)
      @level = 1
    end

    def result
      hash = {}
      @setting_hash.each do |k, v|
        if v.instance_of?(Hash)
          content_path = v['path']
          yaml_path = nil
          item = Item.new(@level, 0, k,  v, content_path, yaml_path, @config)
          hash[k] = item.result
        else
          hash[k] = v
        end
      end
      yaml_path = nil
      item = Item.new(@level, 0, :root, hash, @content_pn, yaml_path, @config)
      content = item.result
      eruby = PrefixedLineEruby.new(content)
      eruby.result(hash)
    end
  end
end
