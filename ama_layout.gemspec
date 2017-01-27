# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ama_layout/version'

Gem::Specification.new do |spec|
  spec.name          = "ama_layout"
  spec.version       = AmaLayout::VERSION
  spec.authors       = ["Michael van den Beuken", "Ruben Estevez", "Jordan Babe", "Mathieu Gilbert", "Ryan Jones", "Darko Dosenovic", "Jonathan Weyermann", "Adam Melnyk", "Kayt Campbell", "Kathleen Robertson", "Jesse Doyle"]
  spec.email         = ["michael.beuken@gmail.com", "ruben.a.estevez@gmail.com", "jorbabe@gmail.com", "mathieu.gilbert@ama.ab.ca", "ryan.michael.jones@gmail.com", "darko.dosenovic@ama.ab.ca", "jonathan.weyermann@ama.ab.ca", "adam.melnyk@ama.ab.ca", "kayt.campbell@ama.ab.ca", "kathleen.robertson@ama.ab.ca", "jesse.doyle@ama.ab.ca"]
  spec.summary       = %q{.ama.ab.ca site layouts}
  spec.description   = %q{.ama.ab.ca site layouts}
  spec.homepage      = "https://github.com/amaabca"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "foundation-rails", "~> 6.2.4.0"
  spec.add_dependency "rails", ">= 4.2"
  spec.add_dependency "sass-rails", "~> 5.0"
  spec.add_dependency "font-awesome-sass", "4.7.0"
  spec.add_dependency "draper", "3.0.0.pre1"
  spec.add_dependency "browser", "~> 2.0"
  spec.add_dependency "breadcrumbs_on_rails", "~> 3.0.1"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 11.0"
  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_girl"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "combustion"
  spec.add_development_dependency "sqlite3"
end
