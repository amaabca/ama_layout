# frozen_string_literal: true

require_relative '../../app/helpers/ama_layout_partial_helper'

module AmaLayout
  class AmaLayoutView < ActionView::Base
    include AmaLayoutPartialHelper

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
