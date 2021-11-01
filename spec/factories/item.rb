# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    sequence(:name) { Faker::Name.name }
    sequence(:description) { Faker::Name.name }
    price { 456 }
    status { 0 }
  end
end
