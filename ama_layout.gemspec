# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ama_layout/version'

Gem::Specification.new do |spec|
  spec.name          = "ama_layout"
  spec.version       = AmaLayout::VERSION
  spec.authors       = ["Michael van den Beuken"]
  spec.email         = ["michael.beuken@gmail.com"]
  spec.summary       = %q{.ama.ab.ca site layouts}
  spec.description   = %q{.ama.ab.ca site layouts}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "foundation-rails", "5.4.5.0"
  spec.add_dependency "rails", ">= 4"
  spec.add_dependency "sass-rails"
  spec.add_dependency "font-awesome-sass"
  spec.add_dependency "draper"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "combustion"
  spec.add_development_dependency "sqlite3"
end
