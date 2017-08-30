module AmaLayout
  class AmaLayoutView < ActionView::Base
    attr_accessor :view_data

    def initialize(args)
      self.view_data = args[:view_data]
      controller = view_data.try(:controller) || ::ApplicationController.new
      context = controller.view_paths
      super(context, {}, controller)
    end

    def method_missing(method, *args, &block)
      view_data.send(method, *args, &block)
    end
  end
end
