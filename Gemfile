# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in makerspec.gemspec
gemspec

gem 'bundler'
gem 'erubis', '~> 2.7.0'
gem 'pre-commit'
gem 'racc'
gem 'rake'
gem 'rb-readline'
gem 'rufo'

group :development, :test, optional: true do
  gem 'aruba'
  # gem 'clitest', path: "../clitest"
  gem 'clitest'
  gem 'rspec', '~> 3.0'
  gem 'rspec_junit_formatter'
  gem 'rubocop'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'
end

group :development, optional: true do
  gem 'coderay', '~> 1.1.1'
  #gem 'pry'
  #gem 'pry-byebug'
  #gem 'pry-doc'
  #gem 'pry-stack_explorer'
  gem 'debug'
  gem 'yard', '~> 0.9.36'
end
#  gem 'pry'
