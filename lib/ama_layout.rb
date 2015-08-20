require "ama_layout/version"
require "rails/all"
require "foundation-rails"
require "sass-rails"
require "font-awesome-sass"
require "draper"
require "ama_layout/navigation"
require "ama_layout/navigation_item"
require "ama_layout/decorators/navigation_decorator"
require "ama_layout/decorators/navigation_item_decorator"
require "pry"

module AmaLayout
  module Rails
    class Engine < ::Rails::Engine
    end
  end
end
