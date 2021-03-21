# frozen_string_literal: true

require_relative 'lib/erubyx/version'

Gem::Specification.new do |spec|
  spec.name          = 'erubyx'
  spec.version       = Erubyx::VERSION
  spec.authors       = ['yasuo kominami']
  spec.email         = ['ykominami@gmail.com']

  spec.summary       = 'make text files with eruby and yaml-file.'
  spec.description   = 'make text files with eruby and yaml-file.'
  spec.homepage      = 'https://ykominami.github.io/erubyx/'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.4.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/ykominami/erubyx.git'
  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aruba'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'coderay', '~> 1.1.1'
  spec.add_development_dependency 'pre-commit'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'pry-stack_explorer'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rb-readline'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter'
  spec.add_development_dependency 'rubocop', '~> 1.7'
  spec.add_development_dependency 'rubocop-rake'
  spec.add_development_dependency 'rubocop-rspec'
  spec.add_development_dependency 'rufo'
  spec.add_dependency 'erubis', '~> 2.7.0'
end
