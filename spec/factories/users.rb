# frozen_string_literal: true

FactoryBot.define do
  factory :user, class: Class.new(OpenStruct) do
    in_renewal { false }
    member_type { 'P' }
    renew_type { 'R' }
    status { 'A' }
    has_outstanding_balance { false }
    member? { true }
    menu_key { 'member' }

    trait :non_member do
      member? { false }
      menu_key { 'non_member' }
    end

    trait :with_accr do
      renew_type { 'A' }
    end

    trait :with_mpp do
      renew_type { 'M' }
    end

    trait :in_renewal do
      in_renewal { true }
      menu_key { 'member_renewal' }
    end

    trait :in_renewal_late do
      in_renewal { true }
      status { 'AL' }
      menu_key { 'member_renewal_late' }
    end

    trait :outstanding_balance do
      has_outstanding_balance { true }
      menu_key { 'member_outstanding_balance' }
    end
  end
end
