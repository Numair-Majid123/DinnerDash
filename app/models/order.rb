# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  paginates_per 5

  belongs_to :user

  default_scope { order(created_at: :desc) }

  enum order_status: {
    Ordered: 0,
    Paid: 1,
    Cancelled: 2,
    Completed: 3
  }
end
