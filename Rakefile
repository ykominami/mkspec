# frozen_string_literal: true

require 'mkspec'

begin
  require "bundler/gem_tasks"
rescue LoadError => exc
  puts exc.message
end

begin
  require 'rspec/core/rake_task'
rescue LoadError => exc
  puts exc.message
end

begin
  RSpec::Core::RakeTask.new(:spec)
rescue NameError, LoadError => exc
  Loggerxcm.fatal(exc.message)
end

begin
  require 'rubocop/rake_task'
rescue LoadError => exc
  Loggerxcm.fatal(exc.message)
end

begin
  RuboCop::RakeTask.new
rescue NameError, LoadError => exc
  Loggerxcm.fatal(exc.message)
end

desc 'Mkspec related operaion'
task default: %i[spec rubocop]
