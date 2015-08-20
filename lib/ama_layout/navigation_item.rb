module AmaLayout
  class NavigationItem
    include ActiveModel::Model
    include Draper::Decoratable

    attr_accessor :text, :icon, :link, :target, :alt, :sub_nav, :current_url

    def sub_nav=(items)
      @sub_nav = items.map { |i| NavigationItem.new i.merge({ current_url: current_url}) }
    end

    def sub_nav
      @sub_nav || []
    end
  end
end
