# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    code { 'PASCOA10' }

    trait :with_promotion do
      promotion
    end

    trait :blank do
      code { '' }
    end
  end
end
