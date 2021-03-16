# frozen_string_literal: true

module Erubyx
  require 'yaml'

  class Root < Objectx
    def initialize(yml_fname, config)
      super()

      yml_pn = Pathname.new(yml_fname)
      yml_pn = config.make_path_under_misc_dir(yml_pn) if yml_pn.exist?
      @_log.debug("yaml_lod yml_pn=#{yml_pn}")
      @setting_hash = YAML.load_file(yml_pn)
      @path = @setting_hash['path']
      @config = config
      @pn = @config.make_path_under_template_and_data_dir(@path)
      @level = 1
    end

    def result
      hash = {}
      @setting_hash.each do |k, v|
        if v.instance_of?(Hash)
          hash[k] = Item.new(@level + 1, k, v['path'], v, @config)
          hash[k].load
        else
          hash[k] = v
        end
      end
      item = Item.new(@level, :root, @pn, hash, @config)
      item.load
      item.result
    end
  end
end
