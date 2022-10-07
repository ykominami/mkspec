# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in makerspec.gemspec
gemspec

gem 'bundler'
gem 'erubis', '~> 2.7.0'
gem 'pre-commit'
gem 'rake', '~> 13.0'
gem 'rb-readline'
gem 'rufo'

group :test, optional: true do
  gem 'rspec', '~> 3.0'
  gem 'rspec_junit_formatter'
  gem 'rubocop'
  gem 'rubocop-rake'
  gem 'rubocop-rspec'

  gem 'aruba'
  gem 'clitest'
  # gem 'pry-byebug'
end

group :development, optional: true do
  gem 'coderay', '~> 1.1.1'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'yard'
end
#  gem 'pry'
