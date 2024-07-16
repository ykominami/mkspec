#Date 2023-03-06

originaal_output_dir

1.Global.yml
YAMLのキー'original_output_dir"で(top_dir)からの相対パスとして指定

globalconfig.rb
class GlobalConfig
    def initialize
        @ost.original_output_dir = @global_hash[get_key_of_original_output_dir].to_s

        Global.ymlから@global_hashに読み込まれている

    def output_dir
        @ost.original_output_dir
    end

 class Mkscript   

    def setup(ost)
        ost.output_deata_top_dir_pn
        ost.original_output_root_dir
