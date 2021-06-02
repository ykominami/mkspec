# frozen_string_literal: true

module Mkspec
  require 'pp'

  class Util
    class << self
      def make_spec_filename(name)
        %(#{name}_spec.rb)
      end

      def get_file_content(file_path)
        File.readlines(file_path).select{ |l| l !~ /^(\s*)#/ }.map { |l| l.chomp }.join("\n")
      end

      def extract_with_eruby(content, hash)
        result = nil
        eruby = Erubis::Eruby.new(content)
        begin
          result = eruby.result(hash)
        rescue StandardError => e
          message = %W[
            #{e.message}
            #{e.backtrace}
          ]
          pp message
          Loggerxcm.fatal_b do
            #{message}
          end
        end
        result
      end

      def extract_in_yaml(yaml_str)
        result = nil
        hash = YAML.load(yaml_str)
        #p "hash=#{hash}"
        result = extract_with_eruby(yaml_str, hash)
        #p "result=#{result}"
        if result.instance_of?(String)
          [YAML.load(result), result]
        else
          [nil , result]
        end
      end

      def extract_in_yaml_all(yaml_str)
        hash , result = extract_in_yaml(yaml_str)
        hs = hash.find{ |key, value| value =~ /<%=/}
        while hs != nil
          hash , result2 = extract_in_yaml(result)
          hs = hash.find{ |key, value| value =~ /<%=/}
          result = result2
        end
        hs
      end

      def extract_in_yaml_file(yaml_file_path)
        result = nil
        #hash = YAML.load_file(yaml_file_path)
        content = get_file_content(yaml_file_path)
        extract_in_yaml(content)
      end
    end
  end
end
