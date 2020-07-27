require 'simplecov'
require 'factory_bot'
require 'ama_layout'
require 'pry'
require 'rspec/rails'
require 'combustion'
require 'timecop'

ENV['RAILS_ENV'] = 'test'

Combustion.initialize!(:all) do
  config.stylesheet_resolver = OpenStruct.new(version: 'v3')
end

Dir['./spec/support/**/*.rb'].sort.each { |file| require file }

FactoryBot.find_definitions

ActionView::TestCase::TestController.instance_eval do
  helper Rails.application.routes.url_helpers
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include Rails.application.routes.url_helpers
end
