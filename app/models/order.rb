# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  belongs_to :user

  paginates_per 5

  validates :order_status, numericality: true

  default_scope { order(created_at: :desc) }

  enum order_status: {
    Ordered: 0,
    Paid: 1,
    Cancelled: 2,
    Completed: 3
  }
end
