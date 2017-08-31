module AmaLayout
  class NavigationItem
    include ActiveModel::Model

    def decorate
      AmaLayout::NavigationItemDecorator.new(self)
    end

    attr_accessor :text, :icon, :link, :target, :alt, :sub_nav, :current_url, :nested_page

    def initialize(args = {})
      self.current_url = args[:current_url]
      super
    end

    def sub_nav=(items)
      @sub_nav = items.map { |i| NavigationItem.new i.merge({ current_url: current_url}) }
    end

    def sub_nav
      @sub_nav || []
    end
  end
end
