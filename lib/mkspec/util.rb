# frozen_string_literal: true

require "pathname"

module Mkspec
  # Utility class providing various helper methods for file and directory manipulation,
  # string validation, content extraction, and more within the Mkspec framework.
  class Util
    # Structs for grouping file and directory paths, and for individual file handling.
    @filex_group = Struct.new(:data_dir, :output_dir, :log_dir, :top_dir_yaml, :resolved_top_dir_yaml,
                              :specific_yaml, :global_yaml)
    @filex = Struct.new(:file_name, :full_path, :pathname)

    # Regular expressions for extracting embedded Ruby code and indentation levels from template strings.
    @re = Regexp.new("<%=([^%]+)%>")
    @re2 = Regexp.new("^(\s*)<%=(.+)%>")

    class << self
      # Loads and returns a hash from a YAML file if it exists, along with the Pathname object.
      # @param path [String] The file path to the YAML file.
      # @return [Array<Hash, Pathname>] A tuple containing the loaded hash and the Pathname object.
      def load_info(path)
        pna = Pathname.new(path)
        hash = if pna.exist?
                 Loggerxcm.debug("Util.load_info Exist pna=#{pna}")
                 extract_in_yaml_file(pna)
               else
                 Loggerxcm.debug("Util.load_info Not Exist pna=#{pna}")
                 {}
               end
        [hash, pna]
      end

      # Prints a string to stdout if it is not nil or empty after stripping whitespace.
      # @param str [String] The string to print.
      def puts_valid_str(str)
        return if str.nil?

        return if str.tr(' ', '').tr("\n", '').empty?

        puts(str)
      end

      # Checks if a variable is nil and logs its value or nil status.
      # @param place [String] Description of the variable's location or usage context.
      # @param varx [Object] The variable to check.
      # @param varxname [String] The name of the variable.
      # @return [Integer] The count of nil variables found.
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

      def check_filex(place, var, varname)
        Loggerxcm.debug("#{place} #{varname}=#{var.pathname}")
      end

      # Validates a path variable, logging a fatal error if it is nil.
      # @param place [String] Description of the variable's location or usage context.
      # @param var [Object] The path variable to validate.
      # @param varname [String] The name of the path variable.
      # @return [Integer] The count of invalid path variables found.
      def validate_path(place, var, varname)
        count = 0
        if var.nil?
          Loggerxcm.fatal("#{place} #{varname}=nil")
          Loggerxcm.fatal("#{place} #{varname}=#{var}")
          count += 1
        end
        count
      end

      # Validates a filex (file exchange) variable, ensuring its pathname is a Pathname instance.
      # @param place [String] Description of the variable's location or usage context.
      # @param varx [Object] The filex variable to validate.
      # @param varnamex [String] The name of the filex variable.
      # @return [Integer] The count of invalid filex variables found.
      def validate_filex(place, varx, varnamex)
        count = 0
        if varx.nil?
          Loggerxcm.fatal("#{place} #{varname}=nil")
          count += 1
        elsif !varx.pathname.instance_of?(Pathname)
          Loggerxcm.fatal("#{place} #{varnamex}.pathname.instance_of?(Pathname) is false [#{varx.pathname.class}] (#{varx.full_path})")
          count += 1
        end
        Loggerxcm.fatal("#{place} #{varnamex}=#{varx.pathname}") if count.positive?
        count
      end

      # Adjusts directories based on environment variables and checks their existence.
      # @return [Struct] A struct containing adjusted directory paths.
      def adjust_dirs_and_files
        data_dir_filex, output_dir_filex, log_dir_filex = adjust_dirs
        top_dir_yaml_filex, resolve_top_dir_yaml_filex, specific_yaml_filex, global_yaml_filex = adjust_files
        @filex_group.new(data_dir_filex, output_dir_filex, log_dir_filex, top_dir_yaml_filex,
                         resolve_top_dir_yaml_filex, specific_yaml_filex, global_yaml_filex)
      end

      # Adjusts directory paths based on predefined environment variables.
      # @return [Array<Struct>] An array of structs for each directory with its name, full path, and Pathname object.
      def adjust_dirs
        %w[
          MKSPEC_DATA_DIR
          MKSPEC_OUTPUT_DIR
          MKSPEC_LOG_DIR
        ].map do |name|
          dir = ENV.fetch(name, nil)
          if dir.nil?
            @filex.new(name, nil, nil)
          else
            pn = Pathname.new(dir)
            if pn.exist?
              @filex.new(name, dir, pn.expand_path)
            else
              @filex.new(name, dir, nil)
            end
          end
        end
      end

      # Adjusts file paths based on predefined environment variables and checks their existence.
      # @return [Array<Struct>] An array of structs for each file with its name, full path, and Pathname object.
      def adjust_files
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

      # Generates a hash from file paths by attempting to resolve the given file paths into a YAML content hash.
      # This method tries to use the resolved file path first; if not available, it falls back to the original path.
      # If a valid path is found, it extracts the YAML content into a hash; otherwise, it returns an empty hash.
      #
      # @param path_filex [Struct] A struct containing the original file path information.
      # @param resolved_filex [Struct] A struct containing the resolved file path information.
      # @return [Hash] The hash generated from the YAML content of the resolved file path, or an empty hash if no valid path is found.
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

      # Retrieves the real paths for a directory and optional command paths within it.
      # This method constructs paths based on a parent directory and optional command directories or files,
      # checking for their existence and returning their real (absolute) paths if they exist.
      #
      # @param parent_dir_pn [Pathname] The parent directory as a Pathname object.
      # @param dir [String] The directory name to join with the parent directory.
      # @param cmd_1 [String, nil] Optional first command or directory to check within the `dir`.
      # @param cmd_2 [String, nil] Optional second command or directory to check within the `dir`.
      # @return [Array<Pathname, Pathname, Pathname>] An array containing the real paths of the directory,
      #         and the two command paths if they exist, or nil for each that doesn't.
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

      # Generates a filename for a spec file based on a given name.
      # This method appends `_spec.rb` to the provided name, creating a conventional filename for a Ruby spec file.
      #
      # @param name [String] The base name for the spec file.
      # @return [String] The generated spec file name.
      def make_spec_filename(name)
        %(#{name}_spec.rb)
      end

      # Retrieves the content of a file, excluding any lines that are comments.
      # This method reads a file, filters out lines that start with a comment marker (`#`),
      # and returns the remaining content as a single string.
      #
      # @param file_path [String] The path to the file.
      # @return [String] The file content with comments removed.
      def get_file_content(file_path)
        get_file_content_lines(file_path).join("\n")
      end

      # Retrieves the content of a file as an array of lines, excluding any lines that are comments.
      # This method reads a file, filters out lines that start with a comment marker (`#`),
      # and returns the remaining lines as an array.
      #
      # @param file_path [String] The path to the file.
      # @return [Array<String>] The file content lines with comments removed.
      def get_file_content_lines(file_path)
        File.readlines(file_path).grep_v(/^(\s*)#/).map(&:chomp)
      end

      def adjust_hash_sub(hash, key_0, value_0, hashx)
        ret =  Util.valid_instance?(value_0, String, Integer, Array, Hash)
        unless ret
          Loggerxcm.debug("Util#adjust_hash_sub util.rb adjust_hash_sub value_0=#{value_0} value_0.class=#{value_0.class} key_0=#{key_0}")
          Loggerxcm.debug("util.rb adjust_hash_sub ret=#{ret}")
          return
        end
        tag_x_ary = tag_analyze_for_string(value_0)
        if tag_x_ary.size.positive?
          tag_x_ary.each do |tag_x|
            # tag_xがStringでない、または空文字列である場合は例外を発生
            # Util.not_empty_sting?は、返値が2個の要素の配列である。
            # 第1要素は空文字列でないStringのインスタンスであればtrue、そうでなけらばfalseが設定される
            # 第2要素は引数をstripした結果を持つ。Stringのインスタンスでなければ、そのままが設定される
            ret = Util.not_empty_string?(tag_x)
            unless ret.first
              Loggerxcm.debug("util.rb 4 adjust_hash_sub ret=#{ret}")
              next
            end
            while (tag_y_ary = tag_analyze_for_string(hash[tag_x])).size.positive?
              tag_y_ary.each do |tag_y|
                ret = Util.not_empty_string?(tag_y)
                unless ret.first
                  Loggerxcm.debug("util.rb 5 ret=#{ret} tag_y.class=#{tag_y.class} ret=#{ret}")
                  next
                end
                value = hash[tag_x]
                ret = Util.not_empty_string?(value)
                unless ret.first
                  Loggerxcm.debug(
                    "util.rb 6 _value.class=#{value.class}"
                  )
                  next
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

      # Adjusts a given hash by processing its keys and values, applying transformations
      # and validations as defined in `adjust_hash_sub`. This method serves as a higher-level
      # interface for hash adjustment, ensuring that the hash conforms to expected structures
      # and values for further processing within the Mkspec framework.
      #
      # @param hash [Hash] The original hash to be adjusted.
      # @return [Hash] The adjusted hash with transformations applied.
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

      # Processes a string content with embedded Ruby code using Erubis, replacing
      # placeholders with actual values from a provided hash. This method is crucial
      # for dynamic content generation where the content includes Ruby code that needs
      # to be evaluated and replaced based on runtime data.
      #
      # @param content [String] The string content containing embedded Ruby code.
      # @param hash [Hash, nil] The hash containing values to replace placeholders in the content.
      # @return [String] The processed content with Ruby code evaluated and placeholders replaced.
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

      # Analyzes a string for embedded Ruby code placeholders and returns an array of
      # the placeholders found. This method is used to identify all the dynamic parts
      # within a string that are meant to be replaced with actual values, facilitating
      # the process of dynamic content generation.
      #
      # @param line [String] The string to be analyzed for embedded Ruby code placeholders.
      # @return [Array<String>] An array of placeholders found in the string.
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

      # Analyzes an array of strings for embedded Ruby code placeholders and returns
      # a flattened array of all placeholders found across the strings. This method
      # extends `tag_analyze_for_string` to work with multiple strings, aggregating
      # the results into a single array.
      #
      # @param lines [Array<String>] The array of strings to be analyzed.
      # @return [Array<String>] A flattened array of placeholders found across the strings.
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

      # Analyzes the contents of a string for embedded Ruby code placeholders and returns an array of
      # the placeholders found. This method is particularly useful for identifying dynamic parts within
      # a string that are intended to be replaced with actual values, aiding in the process of dynamic
      # content generation.
      #
      # @param contents [String] The string content to be analyzed.
      # @return [Array<String>] An array of placeholders found within the contents.
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

      # Extracts and processes YAML content from a string, applying any necessary transformations
      # based on the provided hash. This method safely loads YAML content, merges it with an optional
      # hash for additional context, and then adjusts the merged hash to ensure it conforms to expected
      # structures and values. It's particularly useful for dynamic YAML content generation where
      # placeholders within the YAML string need to be replaced with actual values.
      #
      # @param yaml_str [String] The YAML string to process.
      # @param hash [Hash, nil] An optional hash containing values to replace placeholders in the YAML string.
      # @return [Object] The loaded YAML content after processing.
      def extract_in_yaml(yaml_str, hash = nil)
        error_count = 0
        Loggerxcm.debug "Util extract_in_yaml ############################ 1"
        Loggerxcm.debug "Util extract_in_yaml yaml_str=#{yaml_str}"
        Loggerxcm.debug "Util extract_in_yaml ############################ 2"
        #        raise Mkspec::MkspecDebugError, "util.rb 14 hs.class=#{hash.class}" if hash.instance_of?(Array)
        ret = Util.not_empty_string?(yaml_str.to_s)
        unless ret.first
          Loggerxcm.debug("extract_in_yaml 1 ret=#{ret}")
          return {}
        end
        Loggerxcm.debug "Util extract_in_yaml ############################ 3"

        yaml_hash ||= {}
        if Util.not_empty_string?(yaml_str).first
          begin
            yaml_hash = YAML.safe_load(yaml_str, permitted_classes: [Pathname])
          rescue StandardError => exc
            Loggerxcm.fatal(exc)
            Loggerxcm.fatal("extract_in_yaml XX")
            error_count += 1
          end

          begin
            yaml_hash = yaml_hash.first if yaml_hash.is_a?(Array)
          rescue StandardError => exc
            Loggerxcm.fatal(exc)
            Loggerxcm.fatal("extract_in_yaml YY")
            error_count += 1
          end
        end
        if error_count.positive?
          Loggerxcm.debug("extract_in_yaml 2")
          # raise
          return {}
        end

        hash = {} unless Util.not_empty_hash?(hash).first
        hash_x = yaml_hash.merge(hash)
        hash_y = adjust_hash(hash_x)
        ret = Util.not_empty_string?(yaml_str)
        Loggerxcm.debug("extract_in_yaml A ret=#{ret}")
        unless ret.first
          Loggerxcm.debug(
            "util.rb extract_in_yaml 16 yaml_str=#{yaml_str}"
          )
          # raise
          return {}
        end
        Loggerxcm.debug "hash_y=#{hash_y}"
        ret2 = Util.not_empty_hash?(hash_y)
        Loggerxcm.debug "extract_in_yaml B ret2=#{ret2}"
        unless ret2.first
          Loggerxcm.debug(
            "util.rb extract_in_yaml 17x #{hash_y}"
          )
          # raise
          return {}
        end
        extracted_text = extract_with_eruby(yaml_str, hash_y)
        Loggerxcm.debug "extract_in_yaml C extracted_text=#{extracted_text}"
        array = Util.not_empty_string?(extracted_text)
        unless array.first
          Loggerxcm.debug "extract_in_yaml D ret2=#{array}"
          # raise
          return {}
        end
        Loggerxcm.debug "extract_in_yaml E ret2=#{array}"

        YAML.safe_load(extracted_text)
      end

      # Extracts and processes YAML content from a file, applying any necessary transformations
      # based on the provided hash. This method reads a YAML file, safely loads its content, and
      # merges it with an optional hash for additional context. It then adjusts the merged hash
      # to ensure it conforms to expected structures and values. This is useful for dynamic YAML
      # content generation where placeholders within the YAML file need to be replaced with actual
      # values.
      #
      # @param yaml_file_path [String] The path to the YAML file.
      # @param hashx [Hash, nil] An optional hash containing values to replace placeholders in the YAML content.
      # @return [Hash] The loaded and processed YAML content as a hash.
      def extract_in_yaml_file(yaml_file_path, hashx = nil)
        Loggerxcm.debug("extract_in_yaml_file Util.yaml_file_path=#{yaml_file_path}")
        Loggerxcm.debug("extract_in_yaml_file Util.yaml_file_path.class=#{yaml_file_path.class}")
        ret = Util.not_empty_string?(yaml_file_path.to_s)
        unless ret.first
          Loggerxcm.debug("extract_in_yaml_file empty_string Util.extract_in_yaml_file ret=#{ret}")
          return {}
        end
        pn = Pathname.new(yaml_file_path)
        unless pn.exist?
          Loggerxcm.debug("extract_in_yaml_file exist yaml_file_path=#{yaml_file_path}")
          return {}
        end
        content = File.read(pn.to_s)
        Loggerxcm.debug("Util#extract_in_yaml_file content=#{content}")
        Loggerxcm.debug("Util#extract_in_yaml_file BEFORE hash=#{hashx}")
        hash = extract_in_yaml(content, hashx)
        Loggerxcm.debug("Util#extract_in_yaml_file AFTER hash=#{hashx}")
        dump_var(:hash, hash)
        ret = Util.not_empty_hash?(hash)
        if ret.first

          hash
        else
          {}
        end
      end

      def check_numeric(tmp, num)
        Util.numeric?(num) && tmp.size > num && Util.numeric?(tmp[num])
      end

      def numeric?(lookahead)
        if lookahead.instance_of?(String)
          return false if lookahead.match?(/\./)

          str = lookahead.strip
          mdata = /[:blank:]/.match(str)
          return false if mdata.nil?

          num = str.to_i
          num.negative? ? false : true

        elsif lookahead.instance_of?(Integer)
          lookahead.negative? ? false : true
        else
          false
        end
      end

      # Checks if the given string is not empty after stripping whitespace.
      # Similar to `nil_or_not_empty_string?` but does not consider nil as valid.
      # @param str [String] The string to check.
      # @return [Array<Boolean, Integer>] A tuple with the result and the check identifier.
      def nil_or_not_empty_string?(str)
        return [true, 1] unless str
        return [false, 2] unless str.instance_of?(String)

        stripped_str = str.strip
        return [false, 3] if stripped_str.empty?

        [true, 4]
      end

      # Checks if the given hash is not empty.
      # This method returns a tuple where the first element is a boolean indicating the result,
      # and the second element is an integer representing the specific check that was performed.
      # @param hash [Hash] The hash to check.
      # @return [Array<Boolean, Integer>] A tuple with the result and the check identifier.
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

      # Logs the name and value of a variable for debugging purposes.
      # This method is useful for tracking variable values at different points in the code.
      # @param name [Symbol] The name of the variable.
      # @param value [Object] The value of the variable.
      def dump_var(name, value)
        Loggerxcm.debug("Util#dump_var name=#{name}")
        Loggerxcm.debug("Util#dump_var value=#{value}")
      end

      # Analyzes lines of content to determine the indentation level of embedded Ruby code.
      # This method is useful for processing template strings to understand their structure.
      # @param content_lines [Array<String>] The lines of content to analyze.
      # @return [Hash] A hash mapping Ruby code to its indentation level.
      def analyze(content_lines)
        content_lines.each_with_object({}) do |l, state|
          next unless @re2.match(l)

          space = Regexp.last_match[1]
          key = Regexp.last_match[2].strip
          state[key] = space.size
        end
      end

      # Checks if the given object is an instance of Hash.
      # This method is useful for type validation before performing operations that expect a hash.
      # @param hash [Object] The object to check.
      # @return [Boolean] True if the object is an instance of Hash, false otherwise.
      def valid_hash_instance?(hash)
        return false unless hash

        hash.instance_of?(Hash)
      end

      # Validates that a specific key in a hash maps to a value of a given class.
      # This method is useful for ensuring data integrity in hash structures.
      # @param hash [Hash] The hash to validate.
      # @param key [Object] The key to check in the hash.
      # @param klass [Class] The class that the value should be an instance of.
      # @return [Boolean] True if the value is an instance of the specified class, false otherwise.
      def valid_hash?(hash, key, klass)
        x = hash[key]
        x && !x.instance_of?(klass) ? false : true
      end

      # Recursively validates that a specific key in a nested hash maps to a value of a given class.
      # This method extends `valid_hash?` to work with nested structures.
      # @param hash [Hash] The hash to validate.
      # @param key [Object] The key to check in the hash.
      # @param klass [Class] The class that the value should be an instance of.
      # @return [Boolean] True if all instances of the key in the hash and its sub-hashes are of the specified class, false otherwise.
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

      # Checks if the given object is an instance of Array.
      # @param item [Object] The object to check.
      # @return [Boolean] True if the object is an instance of Array, false otherwise.
      def valid_array?(item)
        return false unless item

        item.instance_of?(Array)
      end

      # Checks if the given Pathname object represents an existing path.
      # @param pna [Pathname] The Pathname object to check.
      # @return [Boolean] True if the path exists, false otherwise.
      def valid_pathname?(pna)
        return false unless pna

        pna.exist?
      end

      # Determines if the given object is an instance of any class specified in the arguments.
      # @param item [Object] The object to check.
      # @param klasses [Array<Class>] A list of classes to check against the object.
      # @return [Boolean] True if the object is an instance of any specified class, false otherwise.
      def valid_instance?(item, *klasses)
        ret = klasses.find { |x| item.instance_of?(x) }
        ret != nil
      end

      # Creates a new Struct for adding a test case to a test group with keyword initialization.
      # This Struct includes various fields related to the test case and test group, such as test values, messages, tags, and extra information.
      # @return [Struct] A new Struct with fields for test group and test case information.
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
