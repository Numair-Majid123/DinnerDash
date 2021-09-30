# frozen_string_literal: true

class Item < ApplicationRecord
  has_one_attached :image
  validates :name, presence: true

  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  accepts_nested_attributes_for :categories
end
