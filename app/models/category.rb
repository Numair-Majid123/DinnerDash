# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :category_items, dependent: :destroy
  has_many :items, through: :category_items

  validates :name, presence: true, length: { minimum: 2, maximum: 32 }

  default_scope { order(created_at: :desc) }
end
