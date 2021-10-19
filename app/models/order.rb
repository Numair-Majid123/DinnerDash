# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  belongs_to :user

  validates :order_type, presence: true

  default_scope { order(created_at: :desc) }

  enum order_type: {
    Ordered: 0,
    Paid: 1,
    Cencelled: 2,
    Completed: 3
  }
end
