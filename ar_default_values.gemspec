# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ar_default_values/version'

Gem::Specification.new do |spec|
  spec.name          = "ar_default_values"
  spec.version       = DefaultValues::VERSION
  spec.authors       = ["masarakki"]
  spec.email         = ["masaki@hisme.net"]
  spec.description   = "ActiveRecord with default values"
  spec.summary       = "ActiveRecord with default values"
  spec.homepage      = "https://github.com/masarakki/ar_default_values"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activerecord", ">= 3.2"
  spec.add_runtime_dependency "activesupport", ">= 3.2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
