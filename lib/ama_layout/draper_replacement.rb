module AmaLayout
  module DraperReplacement
    attr_accessor :object

    def h
      ActionView::Base.new(::ActionController::Base.view_paths, {}, ::ApplicationController.new)
    end

    def initialize(args = {})
      self.object = args
    end

    def self.decorate_collection(objects = {})
      objects.map { |o| self.new(o) }
    end

    def method_missing(method, *args, &block)
      return super unless delegatable?(method)

      (object || DraperReplacement).send(method, *args, &block)
    end

    def delegatable?(method)
      object.respond_to?(method) || DraperReplacement.respond_to?(method)
    end
  end
end
