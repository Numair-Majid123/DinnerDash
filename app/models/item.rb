# frozen_string_literal: true

class Item < ApplicationRecord
  include ImageUploader::Attachment(:image)

  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  validates :name, :description, :price, :status, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validates :status, inclusion: { in: [1, 0] }

  accepts_nested_attributes_for :categories

  default_scope { order(created_at: :desc) }
end
