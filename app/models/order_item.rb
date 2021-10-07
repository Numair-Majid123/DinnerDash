# frozen_string_literal: true

class OrderItem < ApplicationRecord
  # accepts_nested_attributes_for :order
  belongs_to :item
  belongs_to :order
end
