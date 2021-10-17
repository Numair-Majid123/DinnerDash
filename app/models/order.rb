# frozen_string_literal: true

class Order < ApplicationRecord
  validates :order_type, presence: true

  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  default_scope { order(created_at: :desc) }

  enum order_type: {
    Ordered: 0,
    Paid: 1,
    Cencelled: 2,
    Completed: 3
  }
end
