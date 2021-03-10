# frozen_string_literal: true

module Erubyx
  require 'yaml'

  class Root
    def initialize(yml_fname, config)
      puts "Root| yml_fname=#{yml_fname}"
      @setting_hash = YAML.load_file(yml_fname)
      @path = @setting_hash['path']
      puts "In Root| @path=#{@path}"
      @config = config
      @pn = @config.make_path_under_data_dir( @path )
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
      p "In Root @pn=#{@pn}"
      item = Item.new(@level, :root, @pn, hash, @config)
      item.load
      item.result
    end
  end
end
