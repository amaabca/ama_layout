# frozen_string_literal: true

module AmaLayout
  module Agent
    class NavigationDecorator < Draper::Decorator
      include AmaLayoutPartialHelper

      delegate_all

      def items
        object.items.map(&:decorate)
      end

      def display_name_text
        "Welcome, #{display_name.titleize}#{cash_drawer_name}"
      end

      def sign_out_link
        return '' unless user

        h.render partial: ama_layout_partial('sign_out_link')
      end

      def top_nav
        return '' unless user

        h.render partial: 'ama_layout/agent/top_nav', locals: { navigation: self }
      end

      def sidebar
        return '' unless user

        h.render partial: 'ama_layout/agent/sidebar', locals: { navigation: self }
      end

      def cash_drawer_name
        user.cash_drawers.any? ? " - #{user.cash_drawers.last.name}" : ''
      end
    end
  end
end
