module AmaLayout
  class NavigationDecorator < Draper::Decorator
    delegate_all

    def items
      object.items.map { |i| i.decorate }
    end

    def sign_out_link
      return "" unless user
      h.content_tag :li do
        h.concat h.link_to "Sign Out", "/logout"
      end
    end

    def top_nav
      h.render partial: "ama_layout/top_nav", locals: { navigation: self } if items.any?
    end

    def sidebar
      h.render partial: "ama_layout/sidebar", locals: { navigation: self } if items.any?
    end
  end
end
