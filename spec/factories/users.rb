FactoryBot.define do
  factory :user, class: Class.new(OpenStruct) do
    in_renewal false
    member_type 'P'
    renew_type 'R'
    status 'A'
    has_outstanding_balance false
    member? true

    trait :non_member do
      member? false
    end

    trait :with_accr do
      renew_type 'A'
    end

    trait :with_mpp do
      renew_type 'M'
    end

    trait :in_renewal do
      in_renewal true
    end

    trait :in_renewal_late do
      in_renewal true
      status 'AL'
    end

    trait :outstanding_balance do
      has_outstanding_balance true
    end
  end
end
