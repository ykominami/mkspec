# frozen_string_literal: true

require "pathname"

module Mkspec
  class Util
    @filex = Struct.new(:file_name, :full_path, :pathname)
    @re = Regexp.new("<%=([^%]+)%>")
    @re2 = Regexp.new("^(\s*)<%=(.+)%>")

    class << self
      def puts_valid_str(str)
        return if str.nil?

        return if str.tr(' ', '').tr("\n", '').empty?

        puts(str)
      end

      def check_var(place, varx, varxname)
        count = 0
        if varx.nil?
          Loggerxcm.debug("#{place} #{varxname}=nil")
          count += 1
        else
          Loggerxcm.debug("#{place} #{varxname}=#{varx}")
        end
        count
      end

      def validate_path(place, var, varname)
        count = 0
        if var.nil?
          Loggerxcm.debug("#{place} #{varname}=nil")
          count += 1
        else
          Loggerxcm.debug("#{place} #{varname}=#{var}")
        end
        count
      end

      def validate_filex(place, varx, varnamex)
        count = 0
        if varx.nil?
          Loggerxcm.debug("#{place} #{varname}=nil")
          count += 1
        elsif varx.pathname.instance_of?(Pathname)
          Loggerxcm.debug("#{place} #{varnamex}=#{varx.pathname}")
        else
          Loggerxcm.debug("#{place} #{varnamex}.pathname.instance_of?(Pathname) is false")
          count += 1
        end
        count
      end

      def check_filex(place, var, varname)
        Loggerxcm.debug("#{place} #{varname}=#{var.pathname}")
      end

      def adjust_paths
        %w[
          MKSPEC_TOP_DIR_YAML_FNAME
          MKSPEC_RESOLVED_TOP_DIR_YAML_FNAME
          MKSPEC_SPECIFIC_YAML_FNAME
          MKSPEC_GLOBAL_YAML_FNAME
        ].map do |name|
          fname = ENV.fetch(name, nil)
          if fname.nil?
            @filex.new(name, nil, nil)
          else
            pn = Pathname.new(fname)
            if pn.exist?
              @filex.new(name, fname, pn.expand_path)
            else
              @filex.new(name, fname, nil)
            end
          end
        end
      end

      def make_hash_from_files(path_filex, resolved_filex)
        if resolved_filex.pathname.exist?
          pnx = resolved_filex.pathname
        elsif path_filex
          pn = path_filex.pathname
          pnx = (pn if pn.exist?)
        end
        if pnx
          Util.extract_in_yaml_file(pnx, {})
        else
          {}
        end
      end

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
          [pn_0, nil, nil]
        end
      end

      def make_spec_filename(name)
        %(#{name}_spec.rb)
      end

      def get_file_content(file_path)
        get_file_content_lines(file_path).join("\n")
      end

      def get_file_content_lines(file_path)
        File.readlines(file_path).grep_v(/^(\s*)#/).map(&:chomp)
      end

      def adjust_hash_sub(hash, key_0, value_0, hashx)
        unless Util.valid_instance?(value_0, String, Integer, Array, Hash)
          Loggerxcm.debug("Util#adjust_hash_sub util.rb adjust_hash_sub value_0=#{value_0} value_0.class=#{value_0.class} key_0=#{key_0}")
          raise Mkspec::MkspecDebugError, "util.rb adjust_hash_sub 1 key_0=#{key_0}"
        end
        tag_x_ary = tag_analyze_for_string(value_0)
        if tag_x_ary.size.positive?
          tag_x_ary.each do |tag_x|
            # tag_xがStringでない、または空文字列である場合は例外を発生
            # Util.not_empty_sting?は、返値が2個の要素の配列である。
            # 第1要素は空文字列でないStringのインスタンスであればtrue、そうでなけらばfalseが設定される
            # 第2要素は引数をstripした結果を持つ。Stringのインスタンスでなければ、そのままが設定される
            raise(MkspecAppError, "util.rb 4 tag_x.class=#{tag_x.class}") unless Util.not_empty_string?(tag_x).first

            while (tag_y_ary = tag_analyze_for_string(hash[tag_x])).size.positive?
              tag_y_ary.each do |tag_y|
                unless Util.not_empty_string?(tag_y).first
                  raise(MkspecAppError,
                        "util.rb 5 tag_y.class=#{tag_y.class}")
                end
                value = hash[tag_x]
                unless Util.not_empty_string?(value).first
                  raise(MkspecAppError,
                        "util.rb 6 _value.class=#{value.class}")
                end
                hashx[tag_y] = hash[tag_y]
                hashx[tag_x] = extract_with_eruby(value, hashx)
                tag_x = tag_y
              end
            end
            hashx[tag_x] = hash[tag_x]
            hashx[key_0] = extract_with_eruby(value_0, hashx)
          end
        else
          hashx[key_0] = value_0
        end
      end

      def adjust_hash(hash)
        return {} unless Util.valid_hash_instance?(hash)

        hash.each_with_object({}) do |hsx, hashx|
          key_0 = hsx[0]
          value_0 = hsx[1]
          # Loggerxcm.debug("=--- 0")
          # Loggerxcm.debug("adjust_hash 0 hashx=#{hashx}")
          # Loggerxcm.debug("adjust_hash 0 hsx=#{hsx}")
          # Loggerxcm.debug("adjust_hash 0 hash=#{hash}")
          # Loggerxcm.debug("=--- 0 End")
          adjust_hash_sub(hash, key_0, value_0, hashx)
          # Loggerxcm.debug("=--- 4")
          # Loggerxcm.debug("adjust_hash 4 hashx=#{hashx}")
          # Loggerxcm.debug("adjust_hash 4 hsx=#{hsx}")
          # Loggerxcm.debug("adjust_hash 4 hash=#{hash}")
          # Loggerxcm.debug("=--- 4 End")
        end
      end

      def extract_with_eruby(content, hash = {})
        unless Util.not_empty_string?(content).first
          raise(MkspecAppError,
                "util.rb extract_with_eruby 20 content=#{content}")
        end
        unless valid_hash_instance?(hash)
          raise(MkspecAppError,
                "util.rb extract_with_eruby 12 contnet.class=#{hash.class}")
        end
        Mkspec::Loggerxcm.debug("=========== 1")
        Mkspec::Loggerxcm.debug("0 extract_with_eruby hash=#{hash}")
        Mkspec::Loggerxcm.debug("=========== 2")
        Mkspec::Loggerxcm.debug("0 extract_with_eruby content=#{content}")
        Mkspec::Loggerxcm.debug("=========== 3")
        # extract_in_yamlの場合は、
        # <%= item => という形式のものは、
        # 渡されたハッシュで全て展開できると想定しているが、
        # extracct_with_erubyの場合は、
        # <%  %>で記述したRubyスクリプトで変数が定義されることがあるので、
        # 必ずしも、与えられたハッシュだけでもれなく置き換えが
        # 出来なくても、例外が発生しない場合がある。
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
        until pos.nil?
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
          lines.inject([]) do |ary, l|
            ary += tag_analyze_for_string(l)
            ary
          end
        else
          []
        end
      end

      def tag_analyze_for_contents(contents)
        lines = contents.split("\n")
        if lines
          lines.inject([]) do |ary, l|
            ary += tag_analyze_for_string(l)
            ary
          end
        else
          []
        end
      end

      def extract_in_yaml(yaml_str, hash = nil)
        raise Mkspec::MkspecDebugError, "util.rb 14 hs.class=#{hash.class}" if hash.instance_of?(Array)
        return {} unless Util.not_empty_string?(yaml_str.to_s).first

        if Util.not_empty_string?(yaml_str).first
          begin
            yaml_hash = YAML.safe_load(yaml_str, permitted_classes: [Pathname])
          rescue => exc
            Loggerxcm.fatal(exc)
          end
          yaml_hash ||= {}
        else
          yaml_hash = {}
        end

        hash = {} unless Util.not_empty_hash?(hash).first
        hash_x = yaml_hash.merge(hash)
        hash_y = adjust_hash(hash_x)
        unless Util.not_empty_string?(yaml_str).first
          raise Mkspec::MkspecDebugError.new(
            "util.rb extract_in_yaml 16 yaml_str", yaml_str
          )
        end
        unless Util.not_empty_hash?(hash_y).first
          raise Mkspec::MkspecDebugError.new(
            "util.rb extract_in_yaml 17x", hash_y
          )
        end
        extracted_text = extract_with_eruby(yaml_str, hash_y)
        array = Util.not_empty_string?(extracted_text)
        raise Mkspec::MkspecDebugError.new("extract_in_yaml 2 ", array) unless array.first

        YAML.safe_load(extracted_text)
      end

      def extract_in_yaml_file(yaml_file_path, hashx = nil)
        Loggerxcm.debug("yaml_file_path=#{yaml_file_path}")
        Loggerxcm.debug("yaml_file_path.class=#{yaml_file_path.class}")
        raise Mkspec::MkspecDebugError, "util.rb 15 yml_file_path=#{yaml_file_path}" unless Util.not_empty_string?(yaml_file_path.to_s).first

        pn = Pathname.new(yaml_file_path)
        Loggerxcm.debug("yaml_file_path=#{yaml_file_path}")
        raise Mkspec::MkspecDebugError.new("util.rb 18 #{pn}", pn) unless pn.exist?

        content = File.read(pn.to_s)
        Loggerxcm.debug("Util#extract_in_yaml_file content=#{content}")
        Loggerxcm.debug("Util#extract_in_yaml_file hash=#{hashx}")
        hash = extract_in_yaml(content, hashx)
        dump_var(:hash, hash)
        raise Mkspec::MkspecDebugError, "extract_in_yaml_file 1 ret=#{ret}" unless Util.not_empty_hash?(hash).first

        hash
      end

      def check_numeric_and_raise(tmp, num, error)
        raise error if tmp.size > num && Util.numeric?(tmp[num])
      end

      def numeric?(lookahead)
        #lookAhead.match?(/[[:digit:]]/)
        if lookahead.to_i.zero?
          chunk = lookahead.strip
          if chunk.size == 1
            #if chunk.match?(/0/)
            chunk == "0"
          else
            false
          end
        else
          !lookahead.match?(/\./)
        end
      end

      def nil_or_not_empty_string?(str)
        return [true, 1] unless str
        return [false, 2] unless str.instance_of?(String)

        stripped_str = str.strip
        return [false, 3] if stripped_str.empty?

        [true, 4]
      end

      def not_empty_string?(str)
        return [false, 1] unless str
        return [false, 2] unless str.instance_of?(String)

        stripped_str = str.strip
        return [false, 3] if stripped_str.empty?

        [true, 4]
      end

      def not_empty_hash?(hash)
        return [false, 1] unless hash
        return [false, 2] unless hash.instance_of?(Hash)
        return [false, 3] if hash.empty?

        [true, 4]
      end

      def dump_var(name, value)
        Loggerxcm.debug("Util#dump_var name=#{name}")
        Loggerxcm.debug("Util#dump_var value=#{value}")
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
        ret = false if x && !x.instance_of?(klass)
        ret
      end

      def validate_hash(hash, key, klass)
        ret = true
        hash.each do |k, v|
          if k == key
            ret = false unless v.instance_of?(klass)
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

      def valid_pathname?(pna)
        return false unless pna

        pna.exist?
      end

      def valid_instance?(item, *klasses)
        ret = klasses.find { |x| item.instance_of?(x) }
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
