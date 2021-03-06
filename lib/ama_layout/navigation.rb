# frozen_string_literal: true

module AmaLayout
  class Navigation
    include ActiveModel::Model

    def decorate
      AmaLayout::NavigationDecorator.new(self)
    end

    attr_accessor :user, :current_url, :nav_file_path, :display_name

    def initialize(args = {})
      args = defaults.merge args
      super
    end

    cattr_accessor :member do
      'member'
    end

    cattr_accessor :non_member do
      'non-member'
    end

    cattr_accessor :member_in_renewal do
      'member-in-renewal'
    end

    cattr_accessor :member_in_renewal_late do
      'member-in-renewal-late'
    end

    cattr_accessor :member_with_outstanding_balance do
      'member-with-outstanding-balance'
    end

    def items
      navigation_items.fetch(user.try(:navigation), []).map do |n|
        NavigationItem.new n.merge(current_url: current_url)
      end
    end

    def navigation_items
      YAML.safe_load(ERB.new(File.read(nav_file_path)).result)
    end

    def email
      user.email
    end

    private

    def defaults
      {
        nav_file_path: File.join(
          Gem.loaded_specs['ama_layout'].full_gem_path,
          'lib',
          'ama_layout',
          'navigation.yml'
        )
      }
    end
  end
end
