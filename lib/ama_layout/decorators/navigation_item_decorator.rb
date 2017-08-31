module AmaLayout
  class NavigationItemDecorator
    include AmaLayout::DraperReplacement

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
      "side-nav__child-link--active-page" if active_link?
    end

  private
    def active_link?
      sub_nav.map(&:link).push(link).include? current_url_without_query
    end

    def current_url_without_query
      URI.parse(current_url).tap { |uri| uri.query = nil }.to_s
    rescue URI::InvalidURIError
      current_url
    end
  end
end
