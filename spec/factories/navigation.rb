# frozen_string_literal: true

FactoryBot.define do
  factory :navigation, class: AmaLayout::Navigation do
    current_url { 'http://waffleemporium.ca' }
  end
end
