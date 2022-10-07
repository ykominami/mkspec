# frozen_string_literal: true

require 'mkspec'

begin
  require 'rspec/core/rake_task'
rescue LoadError => e
  puts e.message
end

begin
  RSpec::Core::RakeTask.new(:spec)
rescue NameError, LoadError => e
  puts e.message
end

begin
  require 'rubocop/rake_task'
rescue LoadError => e
  puts e.message
end

begin
  RuboCop::RakeTask.new
rescue NameError, LoadError => e
  puts e.message
end

desc 'Mkspec related operaion'
task default: %i[spec rubocop]
