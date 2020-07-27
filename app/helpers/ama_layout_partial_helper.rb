# frozen_string_literal: true

module AmaLayoutPartialHelper
  def ama_layout_partial(partial)
    "ama_layout/#{ama_layout_partial_version}/#{partial}"
  end

  def ama_layout_partial_version
    @ama_layout_partial_version ||= Rails.configuration.stylesheet_resolver.version
  end
end
