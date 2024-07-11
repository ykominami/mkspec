# frozen_string_literal: true

require "pathname"
require "bundler/setup"
require "mkspec"

$LOAD_PATH.unshift File.expand_path("../../lib", __dir__)

if RUBY_VERSION < "1.9.3"
  Dir.glob(File.expand_path("support/**/*.rb", __dir__)).each do |f|
    require File.join(File.dirname(f), File.basename(f, ".rb"))
  end
else
  Dir.glob(File.expand_path("support/*.rb", __dir__)).sort.each { |f| require_relative f }
  Dir.glob(File.expand_path("support/**/*.rb", __dir__)).sort.each { |f| require_relative f }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  #  config.filter_run_when_matching(focus: true)

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def logger_init_x
  # log_dir = ENV.fetch('MKSPEC_LOG_DIR', "./test_data/logs")
  log_dir = ENV.fetch('MKSPEC_LOG_DIR', "./test_data/logs")
  logger_init(log_dir, level: :fatal, stdout_flag: true) #1
  # logger_init(log_dir, level: :debug, stdout_flag: true) #1
  # logger_init(log_dir, level: :error, stdout_flag: true) #1
  # logger_init(log_dir, level: :warn, stdout_flag: true) #1
  # logger_init(log_dir, level: :info, stdout_flag: true) #1
  logger_init(log_dir, level: :fatal, stdout_flag: false) #1
end
# logger_init("./logs")
# logger_init(log_dir, level: :fatal)
# logger_init(log_dir, level: :debug)

# debug: Logger::DEBUG,
#  info: Logger::INFO,
#  warn: Logger::WARN,
#  error: Logger::ERROR,
#  fatal: Logger::FATAL,
#  unknown: Logger::UNKNOWN

# logger_init(log_dir, level: :info, stdout_flag: true) #1
# fatal
# info
# warn
# error
# logger_init(log_dir, level: :warn, stdout_flag: true) # 2
# fatal
# warn
# error
# logger_init(log_dir, level: :error, stdout_flag: true) # 3
# fatal
# warn
# logger_init(log_dir, level: :fatal, stdout_flag: true) # 4
# fatal
# logger_init(log_dir, level: :unknown, stdout_flag: true) # 5

def logger_close
  Mkspec::Loggerxcm.close
end

def logger_init(log_dir_pn, stdout_flag: true, level: :info)
  Mkspec::Loggerxcm.init("mk_", :default, log_dir_pn, stdout_flag, level)
end

class TestHelp
  def self.make_testconf
    top_dir_yaml_file, resolved_top_dir_yaml_file, specific_yaml_file, global_yaml_file = Mkspec::Util.adjust_paths

    Mkspec::Util.check_filex("TestHelp.make_testconf", top_dir_yaml_file, "top_dir_yaml_file")
    Mkspec::Util.check_filex("TestHelp.make_testconf", resolved_top_dir_yaml_file, "resolved_top_dir_yaml_file")
    Mkspec::Util.check_filex("TestHelp.make_testconf", specific_yaml_file, "specific_yaml_file")
    Mkspec::Util.check_filex("TestHelp.make_testconf", global_yaml_file, "global_yaml_file")

    original_spec_file_path = "spec"
    pna = Pathname.new(original_spec_file_path).expand_path
    Mkspec::TestConf.new(
      top_dir_yaml_file,
      resolved_top_dir_yaml_file,
      specific_yaml_file,
      global_yaml_file,
      "mkspec",
      "",
      pna
    )
  end
end
