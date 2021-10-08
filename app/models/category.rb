# frozen_string_literal: true

class Category < ApplicationRecord
  validates :name, presence: true

  has_many :category_items, dependent: :destroy
  has_many :items, through: :category_items

  accepts_nested_attributes_for :items

  default_scope { order(created_at: :desc) }
end
