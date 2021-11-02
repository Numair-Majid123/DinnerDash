# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    sequence(:name) { Faker::Name.unique.name }
  end
end
