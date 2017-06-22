FactoryGirl.define do
  factory :user, class: OpenStruct do
    member true
    in_renewal false
    member_type 'P'
    renew_type 'R'
    status 'A'
    coverage 'BASIC'
    renew_date 3.months.from_now
    has_outstanding_balance false

    trait :non_member do
      member false
    end

    trait :with_accr do
      renew_type 'A'
    end

    trait :with_mpp do
      renew_type 'M'
    end

    trait :in_renewal do
      in_renewal true
      renew_date 15.days.from_now
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
