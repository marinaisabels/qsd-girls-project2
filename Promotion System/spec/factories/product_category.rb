# frozen_string_literal: true

FactoryBot.define do
  factory :product_category do
    name { 'E-mail' }
    code { 'EMAIL' }

    trait :blank do
      name { '' }
      code { '' }
    end
  end
end
