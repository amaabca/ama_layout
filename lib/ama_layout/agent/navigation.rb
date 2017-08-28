module AmaLayout
  module Agent
    class Navigation
      include ActiveModel::Model
      include Draper::Decoratable

      attr_accessor :user, :current_url, :nav_file_path, :display_name

      def initialize(args = {})
        args = defaults.merge args
        super
      end

      def items
        navigation_items.map do |n|
          NavigationItem.new n.merge({ current_url: current_url})
        end
      end

      def navigation_items
        YAML.load ERB.new(File.read nav_file_path).result
      end

    private

      def defaults
        {
          nav_file_path: File.join(Gem.loaded_specs["ama_layout"].full_gem_path, "lib", "ama_layout", "agent_navigation.yml")
        }
      end
    end
  end
end
