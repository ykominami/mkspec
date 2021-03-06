#!/usr/bin/env ruby
# frozen_string_literal: true

require 'bundler/setup'
require 'erubyx'

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# (If you use this, don't forget to add pry to your Gemfile!)
# require 'pry'
# Pry.start

#require 'irb'
#IRB.start(__FILE__)


fname = ARGV[0]
dir = "."
opt = "detect"
case ARGV.size
when 2
  dir = ARGV[1]
when 3
  dir = ARGV[1]
  opt = ARGV[2]
else
  opt = "all"
end

p fname
p dir
p opt
#exit 0

hs = {}
start_char = 'f'
limit = 6
data_top_dir = Erubyx::DATA_TOP_DIR
make_arg = Erubyx::MAKE_ARG

tsg = Erubyx::TestScriptGroup.new( fname, start_char, limit, make_arg )
tsg.setup

def process_detect(tsg, data_top_dir, make_arg)
  array = tsg.testscripts.map{ |testscript|
    puts testscript.name
    puts testscript.script_name
    testscript.test_groups.map{ |test_group|
      puts "== test_group"
      puts test_group.name
      puts "  === test_case"
      test_group.test_cases.map{ |test_case|
        puts test_case.name
      }
    }
    puts " ###"
  }
end

def process_all(tsg, data_top_dir, make_arg, output_dir = ".")
  array = tsg.testscripts.map{ |testscript|
    setting = Erubyx::Setting.new(testscript , data_top_dir, make_arg)
    setting.setup
    
    setting.output_yaml
    templatex = Erubyx::Templatex.new(setting)
    templatex.setup
    templatex.output

    [setting, templatex, testscript]
  }
  array.map{|x|
    setting = x[0]
    templatex = x[1]
    testscript = x[2]
    
    yml_fname = setting.yaml_path
    str = Erubyx::Root.new( yml_fname , data_top_dir ).result
    pn = Pathname.new(output_dir)
    pn.mkdir unless pn.exist?
    pn = pn + %!#{testscript.name}_rspec.rb!
    File.open(pn.to_s, 'w'){|file|
      file.write(str)
    }
  }
end

def process_partial_1(tsg, data_top_dir, make_arg)
  testscript = tsg.testscripts[0]
    setting = Erubyx::Setting.new(testscript , data_top_dir, make_arg)
    setting.setup    
    templatex = nil
    
    yml_fname = setting.yaml_path
    str = Erubyx::Root.new( yml_fname , data_top_dir ).result
end

def process_partial(tsg, data_top_dir, make_arg)
  array = tsg.testscripts.map{ |testscript|
    setting = Erubyx::Setting.new(testscript , data_top_dir, make_arg)
    setting.setup    
    templatex = nil
    [setting, templatex]
  }
  array.map{|x|
    setting = x[0]
    templatex = x[1]
    
    yml_fname = setting.yaml_path
    str = Erubyx::Root.new( yml_fname , data_top_dir ).result
  }
end

if opt == "all"
  puts "mode: all"
  process_all(tsg, data_top_dir, make_arg, dir)
elsif opt == "detect"
  puts "mode: detect"
  process_detect(tsg, data_top_dir, make_arg)
else
  puts "mode: partial"
#  process_partial(tsg, data_top_dir, make_arg)
  process_partial_1(tsg, data_top_dir, make_arg)
end
exit 0
#p tsg.result
