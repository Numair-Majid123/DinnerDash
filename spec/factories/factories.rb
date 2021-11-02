# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { Faker::Name.unique.name }
    sequence(:email) { Faker::Internet.unique.email }
    password { '123456' }
    admin { true }
  end
end
