module AmaLayout
  module Agent
    class NavigationDecorator < Draper::Decorator
      delegate_all

      def items
        object.items.map { |i| i.decorate }
      end

      def display_name_text
        "Welcome, #{display_name.titleize}#{cash_drawer_name}"
      end

      def sign_out_link
        return "" unless user
        h.content_tag :li, class: "side-nav__item" do
          h.concat h.link_to "Sign Out", "/logout", class: "side-nav__link"
        end
      end

      def top_nav
        return '' unless user
        h.render partial: "ama_layout/agent/top_nav", locals: { navigation: self }
      end

      def sidebar
        return '' unless user
        h.render partial: "ama_layout/sidebar", locals: { navigation: self }
      end

      def cash_drawer_name
        user.cash_drawers.any? ? " - #{user.cash_drawers.last.name}" : ''
      end
    end
  end
end
