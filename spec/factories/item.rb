# frozen_string_literal: true

FactoryBot.define do
  factory :item do
    sequence(:name) { Faker::Name.unique.name }
    sequence(:description) { Faker::Name.unique.name }
    price { 456 }
    status { 0 }
  end
end
