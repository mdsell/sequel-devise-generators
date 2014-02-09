# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sequel/devise/generators/version'

Gem::Specification.new do |spec|
  spec.name          = "sequel-devise-generators"
  spec.version       = Sequel::Devise::Generators::VERSION
  spec.authors       = ["Michael Sell"]
  spec.email         = ["mdsell@gmail.com"]
  spec.summary       = %q{Rails generators for sequel-devise}
  spec.description   = %q{Provides the Devise generators for sequel-devise and sequel-rails. Similar to the default ActiveRecord generators.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sequel-devise", ">= 0.0.3"
  spec.add_dependency "sequel-rails", ">= 0.9.1"
  spec.add_dependency "rails", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
