# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'admin@locaweb.com.br' }
    password { '123456' }

    trait :blank do
      email { '' }
      password { '' }
    end
  end
end
