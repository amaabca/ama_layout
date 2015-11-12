require "simplecov"
require "ama_layout"
require "pry"
require "rspec/rails"
require "combustion"

ENV["RAILS_ENV"] ||= "test"

Combustion.initialize! :all

Dir["./spec/support/**/*.rb"].sort.each { |file| require file }

ActionView::TestCase::TestController.instance_eval do
  helper Rails.application.routes.url_helpers
end

ActionView::TestCase::TestController.class_eval do
  def _routes
    Rails.application.routes
  end
end

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  config.include Rails.application.routes.url_helpers
end
