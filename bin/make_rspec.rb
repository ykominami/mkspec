require 'erubyx'

yml_fname = ARGV[0]
#data_top_dir = "./hier"
data_top_dir = Erubyx::DATA_TOP_DIR
str = Erubyx::Root.new( yml_fname , data_top_dir ).result
puts "<<<"
puts str
