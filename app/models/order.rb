# frozen_string_literal: true

class Order < ApplicationRecord
  validates :order_type, presence: true

  belongs_to :user

  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  default_scope { order(created_at: :desc) }
end
