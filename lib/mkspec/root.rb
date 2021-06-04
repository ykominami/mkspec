# frozen_string_literal: true

module Mkspec
  require 'yaml'

  class Root
    def initialize(yml_fname, config)
      yml_pn = Pathname.new(yml_fname)
      yml_pn = config.make_path_under_misc_dir(yml_pn) if yml_pn.exist?
      Loggerxcm.debug("Util.extract_in_yaml_file yml_pn=#{yml_pn}")
      @setting_hash = Util.extract_in_yaml_file(yml_pn)
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
          Loggerxcm.debug("Root#extract_in_hash content_path=#{content_path}")
          item = Item.new(@level, 0, k, v, content_path, yaml_path, @config)
          hash[k] = item.result
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
      ret = nil
      hash = {}
      item = make_item(hash)
      content = item.result
      @cont = content
      Loggerxcm.debug("content=#{content}")
      #raise Mkspec::MkspecDebugError
      eruby = Erubis::Eruby.new(content)
      begin
        Loggerxcm.debug("Root#result 1")
        ret = eruby.result(hash)
        Loggerxcm.debug("Root#result 2")
      rescue StandardError => e
        message = [
          e.message,
          e.backtrace.join("\n"),
          "Root#result",
          "@content=#{@content_pn}",
          "content=#{content}"
        ]
        Loggerxcm.fatal(message)
        Loggerxcm.debug("Root#result 3")
        STATE.change(Mkspec::CANNOT_FORMAT_WITH_ERUBY, "Can not get formated ruby script")
      end
      Loggerxcm.debug("Root#result 4")
      raise Mkspec::MkspecDebugError unless STATE.success?
      raise Mkspec::MkspecDebugError unless ret
      raise Mkspec::MkspecDebugError if ret.strip.size == 0
      ret
   end
  end
end
