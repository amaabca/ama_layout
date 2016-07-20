module AmaLayout
  class NavigationDecorator < Draper::Decorator
    delegate_all

    def items
      object.items.map { |i| i.decorate }
    end

    def display_name_text
      name_or_email.truncate(30)
    end

    def sign_out_link
      return "" unless user
      h.content_tag :li, class: "side-nav__item" do
        h.concat h.link_to "Sign Out", "/logout", class: "side-nav__link"
      end
    end

    def top_nav
      h.render partial: "ama_layout/top_nav", locals: { navigation: self } if items.any?
    end

    def sidebar
      h.render partial: "ama_layout/sidebar", locals: { navigation: self } if items.any?
    end

    def name_or_email
      display_name.present? ? "Welcome, #{display_name.titleize}" : email
    end
  end
end
