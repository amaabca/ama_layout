# frozen_string_literal: true

require_relative 'ama_layout_partial_helper'

module AmaLayoutBreadcrumbHelper
  include AmaLayoutPartialHelper

  def show_breadcrumbs
    render partial: ama_layout_partial('breadcrumbs')
  end
end
