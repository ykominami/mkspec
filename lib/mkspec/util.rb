# frozen_string_literal: true

module Mkspec

  class Util
    class << self
      def make_spec_filename(name)
        %(#{name}_spec.rb)
      end

      def get_file_content(file_path)
        get_file_content_lines(file_path).join("\n")
      end

      def get_file_content_lines(file_path)
        File.readlines(file_path).select{ |l| l !~ /^(\s*)#/ }.map(&:chomp)
      end


      def extract_with_eruby(content, hash)
        result = nil
        eruby = Erubis::Eruby.new(content)
        begin
          result = eruby.result(hash)
        rescue StandardError => e
          message = [
            e.message,
            e.backtrace.joiin("\n")
          ]
          Loggerxcm.fatal(message)
        end
        raise Mkspec::MkspecDebugError if result == nil

        result
      end

      def extract_in_yaml(yaml_str)
        result = nil
        hash = YAML.load(yaml_str)
        result = extract_with_eruby(yaml_str, hash)
        if result.instance_of?(String)
          [YAML.load(result), result]
        else
          [nil , result]
        end
      end

      def extract_in_yaml_all(yaml_str)
        #hash , result = extract_in_yaml(yaml_str)
        result = yaml_str
        hs = {}#hash.find{ |key, value| value =~ /<%=/}
        while hs != nil
          hash , result2 = extract_in_yaml(result)
          hs = hash.find{ |key, value| value =~ /<%=/}
          result = result2
        end
        hash
      end

      def extract_in_yaml_file(yaml_file_path)
        result = nil
        #hash = YAML.load_file(yaml_file_path)
        content = get_file_content(yaml_file_path)
        extract_in_yaml_all(content)
      end

      def check_numeric_and_raise(tmp, n , error)
        raise error if tmp.size > n && Util.numeric?(tmp[n])
      end

      def numeric?(lookAhead)
        #lookAhead.match?(/[[:digit:]]/)
        if lookAhead.to_i == 0
          chunk = lookAhead.strip
          if chunk.size == 1
            #if chunk.match?(/0/)
            if chunk == '0'
              true
            else
              false
            end
          else
            false
          end
        else
          if lookAhead.match?(/\./)
            false
          else
            true
          end
        end
      end
    end
  end
end
