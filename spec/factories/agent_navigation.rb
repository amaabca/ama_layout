# frozen_string_literal: true

FactoryBot.define do
  factory :agent_navigation, class: AmaLayout::Agent::Navigation do
    current_url { 'http://waffleemporium.ca' }
  end
end
