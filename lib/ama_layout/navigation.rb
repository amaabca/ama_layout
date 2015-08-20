module AmaLayout
  class Navigation
    include ActiveModel::Model
    include Draper::Decoratable

    attr_accessor :user, :current_url

    def items
      navigation_items.fetch(user.try(:navigation), []).map do |n|
        NavigationItem.new n.merge({ current_url: current_url})
      end
    end

  private
    def navigation_items
      file = File.join Gem.loaded_specs["ama_layout"].full_gem_path, "lib", "ama_layout", "navigation.yml"
      YAML.load ERB.new(File.read file).result
    end
  end
end
