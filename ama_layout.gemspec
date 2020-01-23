# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ama_layout/version'

Gem::Specification.new do |spec|
  spec.name = 'ama_layout'
  spec.version = AmaLayout::VERSION
  spec.authors = [
    'Darko Dosenovic',
    'Jesse Doyle',
    'Kayt Wilson',
    'Michael van den Beuken',
    'Sinead Errity',
    'Zoie Carnegie'
  ]
  spec.email = [
    'darko.dosenovic@ama.ab.ca',
    'jesse.doyle@ama.ab.ca',
    'kayt.wilson@ama.ab.ca',
    'michael.beuken@gmail.com',
    'sinead.errity@ama.ab.ca',
    'zoie.carnegie@ama.ab.ca'
  ]
  spec.summary = '.ama.ab.ca site layouts'
  spec.description = '.ama.ab.ca site layouts'
  spec.homepage = 'https://github.com/amaabca/ama_layout'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0")
  spec.executables = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'breadcrumbs_on_rails', '>= 3'
  spec.add_dependency 'browser', '~> 2.0'
  spec.add_dependency 'foundation-rails', '<= 6.4.3.0'
  spec.add_dependency 'rails', '>= 4.2'
  spec.add_dependency 'redis-rails'
  spec.add_development_dependency 'bundler', '~> 1.17.3'
  spec.add_development_dependency 'combustion'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '>= 11.0'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'timecop'
end
