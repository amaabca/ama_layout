# frozen_string_literal: true

require_relative '../../app/helpers/ama_layout_partial_helper'

module AmaLayout # TODO: remove
  module DraperReplacement
    extend ActiveSupport::Concern

    included do
      include AmaLayoutPartialHelper

      attr_accessor :object, :controller

      def h(view_data = {})
        AmaLayoutView.new(view_data: view_data)
      end

      def initialize(args = {})
        self.object = args
      end

      def method_missing(method, *args, &block)
        return super unless delegatable?(method)

        (object || DraperReplacement).send(method, *args, &block)
      end

      def delegatable?(method)
        object.respond_to?(method) || DraperReplacement.respond_to?(method)
      end

      def self.decorate_collection(objects = {})
        objects.map { |o| self.new(o) }
      end
    end
  end
end
