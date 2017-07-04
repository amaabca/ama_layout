module AmaLayout
  class NotificationScrubber < Rails::Html::PermitScrubber
    def initialize
      super
      self.tags = %w(i a div span strong br em h1 h2 h3 h4 h5 h6 blockquote)
      self.attributes = %w(href class id)
    end

    def skip_node?(node)
      node.text?
    end
  end
end
