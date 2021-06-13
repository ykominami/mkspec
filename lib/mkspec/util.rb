# frozen_string_literal: true

module Mkspec
  class Util
    require 'pry'

    @re = Regexp.new("<%=([^%]+)%>")

    class << self
      def get_path(parent_dir_pn, dir, cmd_1, cmd_2)
        pn_0 = parent_dir_pn.join(dir)
        if pn_0.exist?
          dir_pn = pn_0.realpath

          if cmd_1
            pn_1 = dir_pn.join(cmd_1)
            pn_cmd_1 = pn_1.exist? ? pn_1 : nil
          else
            pn_cmd_1 = nil
          end

          if cmd_2
            pn_2 = dir_pn.join(cmd_2)
            pn_cmd_2 = pn_2.exist? ? pn_2 : nil
          else
            pn_cmd_2 = nil
          end
          [dir_pn, pn_cmd_1, pn_cmd_2]
        else
          [nil, nil, nil]
        end
      end

      def make_spec_filename(name)
        %(#{name}_spec.rb)
      end

      def get_file_content(file_path)
        get_file_content_lines(file_path).join("\n")
      end

      def get_file_content_lines(file_path)
        File.readlines(file_path).select{ |l| l !~ /^(\s*)#/ }.map(&:chomp)
      end

      def adjust_hash_sub(hash, key_0, value_0, hashx)
          Loggerxcm.debug("==== 0")
          Loggerxcm.debug("adjust_hash_sub 0 key_0=#{key_0}")
          Loggerxcm.debug("adjust_hash_sub 0 value_0=#{value_0}")
          Loggerxcm.debug("==== 0 End")
        if value_0.instance_of?(String)
          tag_x_ary = tag_analyze_for_string(value_0)
          if tag_x_ary.size > 0
            for tag_x in tag_x_ary do
              Loggerxcm.debug("adjust_hash_sub 0-1 tag_x=#{tag_x}")
              raise(MkspecAppError, "util.rb 4 tag_x.class=#{tag_x.class}") unless tag_x.instance_of?(String)
              Loggerxcm.debug("=--- 1")
              Loggerxcm.debug("hash=#{hash}")
              Loggerxcm.debug("hashx=#{hashx}")
              while (tag_y_ary = tag_analyze_for_string(hash[tag_x])).size > 0
                for tag_y in tag_y_ary do
                  raise(MkspecAppError, "util.rb 5 tag_y.class=#{tag_y.class}") unless tag_y.instance_of?(String)
                  Loggerxcm.debug("adjust_hash_sub 1 tag_x=#{tag_x}")
                  Loggerxcm.debug("adjust_hash_sub 1 tag_y=#{tag_y}")
                  _value = hash[tag_x]
                  raise(MkspecAppError, "util.rb 6 _value.class=#{_value.class}") unless _value.instance_of?(String)
                  hashx[tag_y] = hash[tag_y]
                  Loggerxcm.debug("adjust_hash_sub 1 _value=#{_value}")
                  Loggerxcm.debug("adjust_hash_sub 1 hash=#{hash}")
                  Loggerxcm.debug("adjust_hash_sub 1-1 hashx=#{hashx}")
                  hashx[tag_x] = extract_with_eruby(_value, hashx)
                  Loggerxcm.debug("adjust_hash_sub 1-2 hashx=#{hashx}")
                  tag_x = tag_y
                end
              end
              Loggerxcm.debug("=--- 1-2")
              hashx[tag_x] = hash[tag_x]
              Loggerxcm.debug("adjust_hash_sub 2-1 key_0=#{key_0}")
              Loggerxcm.debug("adjust_hash_sub 2-1 value_0=#{value_0}")
              Loggerxcm.debug("adjust_hash_sub 2-1 hashx=#{hashx}")
              hashx[key_0] = extract_with_eruby(value_0 , hashx)
              Loggerxcm.debug("adjust_hash_sub 2-2 hashx=#{hashx}")
              Loggerxcm.debug("=--- 1-2 End")
              Loggerxcm.debug("=--- 1 End")
            end
          else
            hashx[key_0] = value_0
          end
        end
      end

      def adjust_hash(hash)
        return {} unless hash
        raise(MkspecAppError, "util.rb 7 hash.class=#{hash.class}") unless hash.instance_of?(Hash)
        hash.inject({}){ |hashx, hsx|
          key_0 = hsx[0]
          value_0 = hsx[1]
          Loggerxcm.debug("=--- 0")
          Loggerxcm.debug("adjust_hash 0 hashx=#{hashx}")
          Loggerxcm.debug("adjust_hash 0 hsx=#{hsx}")
          Loggerxcm.debug("adjust_hash 0 hash=#{hash}")
          Loggerxcm.debug("=--- 0 End")
          adjust_hash_sub(hash, key_0, value_0, hashx)
          Loggerxcm.debug("=--- 4")
          Loggerxcm.debug("adjust_hash 4 hashx=#{hashx}")
          Loggerxcm.debug("adjust_hash 4 hsx=#{hsx}")
          Loggerxcm.debug("adjust_hash 4 hash=#{hash}")
          Loggerxcm.debug("=--- 4 End")
          hashx
        }
      end

      def extract_with_eruby(content, hash = {})
        result = nil
        raise(MkspecAppError, "util.rb 11 content=#{content}") unless content
        raise(MkspecAppError, "util.rb 12 contnet.class=#{content.class}") unless content.instance_of?(String)
        Mkspec::Loggerxcm.debug("=========== 1")
        Mkspec::Loggerxcm.debug("0 extract_with_eruby hash=#{hash}")
        Mkspec::Loggerxcm.debug("=========== 2")
        Mkspec::Loggerxcm.debug("0 extract_with_eruby content=#{content}")
        Mkspec::Loggerxcm.debug("=========== 3")
        hash = {} unless hash

        eruby = Erubis::Eruby.new(content)
        Mkspec::Loggerxcm.debug("=========== 4")
        Mkspec::Loggerxcm.debug("extract_with_eruby content=#{content}")
        Mkspec::Loggerxcm.debug("=========== 5")
        Mkspec::Loggerxcm.debug("extract_with_eruby hash=#{hash}")
        Mkspec::Loggerxcm.debug("=========== 6")
        hash_2 = adjust_hash(hash)
        Mkspec::Loggerxcm.debug("=========== 7")
        Mkspec::Loggerxcm.debug("extract_with_eruby hash_2=#{hash_2}")
        Mkspec::Loggerxcm.debug("=========== 8")
        begin
          result = eruby.result(hash_2)
        rescue StandardError => e
          message = [
            e.message,
            e.backtrace.join("\n")
          ]
          Mkspec::Loggerxcm.debug("*****************util.extract_with_eruby START")
          Mkspec::Loggerxcm.debug(message)
          Mkspec::Loggerxcm.debug("*****************util.extract_with_eruby END")
          STATE.change(CANNOT_FORMAT_WITH_ERUBY)
        end
        raise(Mkspec::MkspecDebugError, "util.rb 13 STATE.exit_code=#{STATE.exit_code}|#{STATE.message}") unless STATE.success?

        result
      end

      def tag_analyze_for_string(l)
        pos = 0
        match_data_array = []
        while pos != nil
          match = @re.match(l, pos)
          if match
            match_data_array << match[1].strip
            pos = match.offset(0)[1]
          else
            pos = nil
          end
        end
        match_data_array.flatten
      end

      def tag_analyze(lines)
        if lines
          lines.inject([]) { |ary, l|
            ary += tag_analyze_for_string(l)
            ary
          }
        else
          []
        end
      end

      def tag_analyze_for_contents(contents)
        lines = contents.split("\n")
        if lines
          lines.inject([]) { |ary, l|
            ary += tag_analyze_for_string(l)
            ary
          }
        else
          []
        end
      end

      def extract_in_yaml(yaml_str, hs = nil)
        raise(Mkspec::MkspecDebugError, "util.rb 14 hs.class=#{hs.class}") if hs.instance_of?(Array)
        if yaml_str && yaml_str.strip.size > 0
          hash = YAML.load(yaml_str)
          hash = {} unless hash
        else
          hash = {}
        end
        return hash if hash.size == 0

        hash_x = if hs
          if hash
            hash.merge(hs)
          else
            hs
          end
        else
          if hash
            hash
          else
            {}
          end
        end
#
        extracted_text = extract_with_eruby(yaml_str, hash_x)
        YAML.load(extracted_text)
      end

      def extract_in_yaml_file(yaml_file_path, hash = nil)
        Loggerxcm.debug("yaml_file_path=#{yaml_file_path}")
        Loggerxcm.debug("yaml_file_path.class=#{yaml_file_path.class}")
        raise(Mkspec::MkspecDebugError, "util.rb 15 yml_file_path=#{yaml_file_path}") unless yaml_file_path
        raise(Mkspec::MkspecDebugError, "util.rb 16") unless (yaml_file_path.instance_of?(String) || yaml_file_path.instance_of?(Pathname))
        pn = Pathname.new(yaml_file_path)
        raise(Mkspec::MkspecDebugError, "util.rb 17 pn.exist?=#{pn.exist?}") unless pn.exist?

        content = get_file_content(yaml_file_path)
        extract_in_yaml(content, hash)
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
