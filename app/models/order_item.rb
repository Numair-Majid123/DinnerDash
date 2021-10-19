# frozen_string_literal: true

class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  validates :quantity, numericality: { greater_than_or_equal_to: 1, less_than: 100 }
end
