# frozen_string_literal: true

module Mkspec
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

    def extract_in_hash(hash)
      @setting_hash.each do |k, v|
        if v.instance_of?(Hash)
          content_path = v['path']
          yaml_path = nil
          item = Item.new(@level, 0, k, v, content_path, yaml_path, @config)
          hash[k] = item.result
          return unless STATE.success?
        else
          hash[k] = v
        end
      end
    end

    def make_item(hash)
      extract_in_hash(hash)
      yaml_path = nil
      Item.new(@level, 0, :root, hash, @content_pn, yaml_path, @config)
    end

    def result
      hash = {}
      item = make_item(hash)
      content = item.result
      return unless STATE.success?
      eruby = PrefixedLineEruby.new(content)
      begin
        eruby.result(hash)
      rescue StandardError => e
        message = %W[
          "3 Item.to_s"
          #{e.to_s}
          "@content=#{@content_pn}"
          "content=#{content}"
        ]
        Loggerxcm.error_b do
          #{ message }
        end
        return STATE.change(CANNOT_GET_RESULT_WITH_ERUBY)
      end
    end
  end
end
