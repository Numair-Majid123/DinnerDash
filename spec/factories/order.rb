# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    # sequence(:order_id) { Faker::IDNumber.croatian_id }
    sequence(:order_status) { 0 }
    sequence(:user_id) { 13 }
  end
end
