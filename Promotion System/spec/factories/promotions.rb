# frozen_string_literal: true

FactoryBot.define do
  factory :promotion do
    name { 'Cyber Monday' }
    description { 'Promoção de Cyber Monday' }
    code { 'CYBER15' }
    coupon_quantity { 5 }
    discount_rate { 10 }
    expiration_date { 1.day.from_now }

    trait :blank do
      name { '' }
      coupon_quantity { '' }
      discount_rate { '' }
      code { '' }
      expiration_date { '' }
    end

    trait :with_product_category do
      product_categories
    end
  end
end
