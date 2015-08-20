module AmaLayout
  class NavigationItemDecorator < Draper::Decorator
    delegate_all

    def sub_nav
      object.sub_nav.map { |sn| sn.decorate }
    end

    def sub_nav_class
      "has-dropdown" if sub_nav.any?
    end

    def top_sub_nav
      h.render partial: "ama_layout/top_sub_nav", locals: { sub_nav: sub_nav } if sub_nav.any?
    end

    def sidebar_sub_nav
      h.render partial: "ama_layout/sub_nav", locals: { sub_nav: sub_nav } if sub_nav.any?
    end

    def active_class
      "activepage" if active_link?
    end

  private
    def active_link?
      binding.pry if link.include? "westworld"
      sub_nav.map(&:link).push(link).include? current_url
    rescue
      binding.pry
    end
  end
end
