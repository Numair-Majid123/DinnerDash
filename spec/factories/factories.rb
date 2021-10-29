# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    password { '123456' }
    admin { true }
  end
end
