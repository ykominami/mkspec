# frozen_string_literal: true

module Erubyx
  class Util
    class << self
      def make_spec_filename(name)
        %(#{name}_spec.rb)
      end

      def extract_yaml(yaml)
        hash = YAML.load_file(yaml)
        content = File.readlines(yaml).map { |l| l.chomp }.join("\n")
        eruby = Erubis::Eruby.new(content)
        begin
          result = eruby.result(hash)
        rescue StandardError => e
          message = %W[
            #{e.message}
            #{e.backtrace}
          ]
          Loggerxcm.error_b do
            #{message}
          end
        end
        YAML.load(result)
      end
    end
  end
end
