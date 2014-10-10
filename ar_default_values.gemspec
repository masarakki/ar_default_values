# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar_default_values/version'

Gem::Specification.new do |spec|
  spec.name          = 'ar_default_values'
  spec.version       = DefaultValues::VERSION
  spec.authors       = ['masarakki']
  spec.email         = ['masaki@hisme.net']
  spec.description   = 'ActiveRecord with default values'
  spec.summary       = 'ActiveRecord with default values'
  spec.homepage      = 'https://github.com/masarakki/ar_default_values'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activerecord', '>= 3.2'
  spec.add_runtime_dependency 'activesupport', '>= 3.2'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rspec-its'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'rdoc'
  spec.add_development_dependency 'sqlite3'
end
