module Erubyx
  class Root
    def initialize(yml_fname, data_top_dir)
      @setting = YAML.load_file(yml_fname)
      @path = @setting['path']
      @data_top_pn = Pathname(data_top_dir)
      @pn = @data_top_pn + @path
      @level = 1
    end

    def result
      hash = {}
      @setting.each do |k, v|
        if v.instance_of?(Hash)
          hash[k] = Item.new(@level + 1, k, v['path'], v, @data_top_pn)
          hash[k].load
        else
          hash[k] = v
        end
      end
      p "In Root @pn=#{@pn}"
      item = Item.new(@level, :root, @pn, hash, @data_top_pn)
      item.load
      item.result
    end
  end
end
