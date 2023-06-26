# frozen_string_literal: true

FactoryBot.define do
  factory :navigation, class: AmaLayout::Navigation do
    current_url { 'http://waffleemporium.ca' }
    user { OpenStruct.new(email: 'john.doe@test.com') }
    display_name { 'John D' }
  end
end
