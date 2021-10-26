# frozen_string_literal: true

class Item < ApplicationRecord
  include ImageUploader::Attachment(:image)
  paginates_per 5

  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  validates :name, :description, :price, :status, presence: true
  validates :name, length: { minimum: 2, maximum: 32 }
  validates :description, length: { minimum: 5, maximum: 500 }
  validates :price, numericality: { in: [100_000, 1] }
  validates :status, inclusion: { in: [1, 0] }, numericality: true

  default_scope { order(created_at: :desc) }
end
