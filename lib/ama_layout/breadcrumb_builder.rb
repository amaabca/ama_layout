module AmaLayout
  class BreadcrumbBuilder < BreadcrumbsOnRails::Breadcrumbs::Builder
    def render
      @elements.map { |e| render_element(e) }.join(@options[:separator])
    end

  private

    def render_element(element)
      name = compute_name(element)
      path = element.path && compute_path(element) || '#'
      render_list_element(name, path, element)
    end

    def render_list_element(name, path, element)
      if element.options.delete(:disabled)
        @context.content_tag :li, @context.link_to(name, '#', class: 'breadcrumbs__link--disabled', rel: 'nofollow')
      else
        @context.content_tag :li, @context.link_to(name, path, element.options)
      end
    end
  end
end
