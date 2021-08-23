# frozen_string_literal: true

module Mkspec
  class Util
    require 'pry'

    @re = Regexp.new("<%=([^%]+)%>")
    @re2 = Regexp.new("^(\s*)<%=(.+)%>")

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
        #if value_0.instance_of?(String) || value_0.instance_of?(Integer) || value_0.instance_of?(Array) || value_0.instance_of?(Hash)
        unless Util.valid_instance?( value_0, String, Integer, Array, Hash)
          Loggerxcm.debug("Util#adjust_hash_sub util.rb adjust_hash_sub value_0=#{value_0} value_0.class=#{value_0.class} key_0=#{key_0}")
          raise(Mkspec::MkspecDebugError, "util.rb adjust_hash_sub 1")
        else
          tag_x_ary = tag_analyze_for_string(value_0)
          if tag_x_ary.size > 0
            for tag_x in tag_x_ary do
              raise(MkspecAppError, "util.rb 4 tag_x.class=#{tag_x.class}") unless Util.not_empty_string?(tag_x).first
              while (tag_y_ary = tag_analyze_for_string(hash[tag_x])).size > 0
                for tag_y in tag_y_ary do
                  raise(MkspecAppError, "util.rb 5 tag_y.class=#{tag_y.class}") unless Util.not_empty_string?(tag_y).first
                  _value = hash[tag_x]
                  raise(MkspecAppError, "util.rb 6 _value.class=#{_value.class}") unless Util.not_empty_string?(_value).first
                  hashx[tag_y] = hash[tag_y]
                  hashx[tag_x] = extract_with_eruby(_value, hashx)
                  tag_x = tag_y
                end
              end
              hashx[tag_x] = hash[tag_x]
              hashx[key_0] = extract_with_eruby(value_0 , hashx)
            end
          else
            hashx[key_0] = value_0
          end
        end
      end

      def adjust_hash(hash)
        return {} unless Util.valid_hash_instance?(hash)
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
        raise(MkspecAppError, "util.rb extract_with_eruby 20 content=#{content}") unless Util.not_empty_string?(content).first
        raise(MkspecAppError, "util.rb extract_with_eruby 12 contnet.class=#{hash.class}") unless valid_hash_instance?(hash)
        Mkspec::Loggerxcm.debug("=========== 1")
        Mkspec::Loggerxcm.debug("0 extract_with_eruby hash=#{hash}")
        Mkspec::Loggerxcm.debug("=========== 2")
        Mkspec::Loggerxcm.debug("0 extract_with_eruby content=#{content}")
        Mkspec::Loggerxcm.debug("=========== 3")
=begin
extract_in_yamlの場合は、
<%= item => という形式のものは、
渡されたハッシュで全て展開できると想定しているが、
extracct_with_erubyの場合は、
<%  %>で記述したRubyスクリプトで変数が定義されることがあるので、
必ずしも、与えられたハッシュだけでもれなく置き換えが
出来なくても、例外が発生しない場合がある。
=end
        eruby = Erubis::Eruby.new(content)
        result = eruby.result(hash)
        Mkspec::Loggerxcm.debug("0 extract_with_eruby result=#{result}")
        Mkspec::Loggerxcm.debug("=========== 4")
        result
      end

      def tag_analyze_for_string(line)
        match_data_array = []
        return match_data_array unless Util.not_empty_string?(line).first
        pos = 0
        while pos != nil
          match = @re.match(line, pos)
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
        return {} unless Util.not_empty_string?(yaml_str.to_s).first
        if Util.not_empty_string?(yaml_str).first
          hash = YAML.load(yaml_str)
          hash = {} unless hash
        else
          hash = {}
        end

        hs = {} unless Util.not_empty_hash?(hs).first
        hash_x = hash.merge(hs)
        hash_y = adjust_hash(hash_x)
        raise(Mkspec::MkspecDebugError, "util.rb extract_in_yaml 16 yaml_str=#{yaml_str}") unless Util.not_empty_string?(yaml_str).first
        raise(Mkspec::MkspecDebugError, "util.rb extract_in_yaml 17 hash_x=#{hash_y}") unless Util.not_empty_hash?(hash_y).first
        extracted_text = extract_with_eruby(yaml_str, hash_y)
        if Util.not_empty_string?(extracted_text).first
          #raise(Mkspec::MkspecDebugError, "extract_in_yaml 1")
          YAML.load(extracted_text)
        else
          raise(Mkspec::MkspecDebugError, "extract_in_yaml 2")
        end
      end

      def extract_in_yaml_file(yaml_file_path, hash = nil)
        Loggerxcm.debug("yaml_file_path=#{yaml_file_path}")
        Loggerxcm.debug("yaml_file_path.class=#{yaml_file_path.class}")
        raise(Mkspec::MkspecDebugError, "util.rb 15 yml_file_path=#{yaml_file_path}") unless Util.not_empty_string?(yaml_file_path.to_s).first
        pn = Pathname.new(yaml_file_path)
        raise(Mkspec::MkspecDebugError, "util.rb 17 pn=#{pn}") unless pn.exist?

        content = get_file_content(yaml_file_path)
        Loggerxcm.debug("Util#extract_in_yaml_file content=#{content}") 
        Loggerxcm.debug("Util#extract_in_yaml_file hash=#{hash}")
        text = extract_in_yaml(content, hash)
        dump_var(:text, text)
        raise(Mkspec::MkspecDebugError, "extract_in_yaml_file 1 ret=#{ret}") unless Util.not_empty_hash?(text).first
        text
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

      def nil_or_not_empty_string?(str)
        return [true, 1] unless str
        return [false, 2] unless str.instance_of?(String)
        stripped_str = str.strip
        return [false, 3] if stripped_str.size == 0
        return [true, 4]
      end

      def not_empty_string?(str)
        return [false, 1] unless str
        return [false, 2] unless str.instance_of?(String)
        stripped_str = str.strip
        return [false, 3] if stripped_str.size == 0
        return [true, 4]
      end

      def not_empty_hash?(hash)
        return [false, 1] unless hash
        return [false, 2] unless hash.instance_of?(Hash)
        return [false, 3] if hash.size == 0
        return [true, 4]
      end

      def dump_var(name , value)
        Loggerxcm.debug("Util#dump_var #{name.to_s}")
        Loggerxcm.debug("Util#dump_var #{value}")
      end

      def analyze(content_lines)
        content_lines.each_with_object({}) do |l, state|
          next unless @re2.match(l)

          space = Regexp.last_match[1]
          key = Regexp.last_match[2].strip
          state[key] = space.size
        end
      end

      def valid_hash_instance?(hash)
        return false unless hash
        hash.instance_of?(Hash)
      end

      def valid_hash?(hash, key, klass)
        ret = true
        x = hash[key]
        if x && ! x.instance_of?(klass)
          ret = false
        end
        ret
      end

      def validate_hash(hash, key, klass)
        ret = true
        hash.each do |k, v|
          if k == key
            unless v.instance_of?(klass)
              ret = false
            end
            break
          elsif v.instance_of?(Hash)
            ret = validate_hash(v, key, klass)
            break unless ret
          end
        end
        ret
      end

      def valid_array?(item)
        return false unless item
        item.instance_of?(Array)
      end

      def valid_pathname?(pn)
        return false unless pn
        pn.exist?
      end 

      def valid_instance?(item, *klasses)
        ret = klasses.find{ |x| item.instance_of?(x) }
        ret != nil
      end

      def make_arg_of_add_test_case_of_testgroup
        Struct.new(
          :testgroup,
          :tcase,
          :test_1,
          :test_1_value,
          :test_1_message,
          :test_1_tag,
          :test_2,
          :test_2_value,
          :test_2_message,
          :test_2_tag,
          :extra,
          keyword_init: true
        )
      end
    end
  end
end
