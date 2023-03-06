# frozen_string_literal: true

require 'pathname'
require 'bundler/setup'
require 'mkspec'
require 'pp'

$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)

if RUBY_VERSION < '1.9.3'
  ::Dir.glob(::File.expand_path('support/**/*.rb', __dir__)).each do |f|
    require File.join(File.dirname(f), File.basename(f, '.rb'))
  end
else
  ::Dir.glob(::File.expand_path('support/*.rb', __dir__)).sort.each { |f| require_relative f }
  ::Dir.glob(::File.expand_path('support/**/*.rb', __dir__)).sort.each { |f| require_relative f }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  #  config.filter_run_when_matching(focus: true)

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def logger_init( log_dir_pn )
  Mkspec::Loggerxcm.init("mk_", :default, log_dir_pn, false, :debug)
end

class TestHelp
  @top_dir_yaml_pna = nil
  @specific_yaml_pna = nil
  @global_yaml_pna = nil
  @conf = nil

  def self.adjust_paths
    @top_dir_yaml_pna ||= Pathname.new( ENV['MKSPEC_TOP_DIR_YAML_FNAME'] ).expand_path
    @resolved_top_dir_yaml_pna ||= Pathname.new( ENV['MKSPEC_RESOLVED_TOP_DIR_YAML_FNAME'] ).expand_path
    @specific_yaml_pna ||= Pathname.new( ENV['MKSPEC_SPECIFIC_YAML_FNAME'] ).expand_path
    @global_yaml_pna ||= Pathname.new( ENV['MKSPEC_GLOBAL_YAML_FNAME'] ).expand_path

    [@top_dir_yaml_pna, @resolved_top_dir_yaml_pna, @specific_yaml_pna, @global_yaml_pna]
  end

  def self.make_testconf
    adjust_paths
    original_spec_file_path = "spec"
    pna = Pathname.new(original_spec_file_path).expand_path
    @conf ||= Mkspec::TestConf.new(
      @top_dir_yaml_pna,
      @resolved_top_dir_yaml_pna,
      @specific_yaml_pna,
      @global_yaml_pna,
      'mkspec',
      '',
      pna
    )

    @conf
  end
end
