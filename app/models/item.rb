# frozen_string_literal: true

class Item < ApplicationRecord
  include ImageUploader::Attachment(:image)
  validates :name, :description, :price, :status, :image, presence: true

  has_many :category_items, dependent: :destroy
  has_many :categories, through: :category_items

  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  accepts_nested_attributes_for :categories

  def self.ids_with_all_categories(category_ids)
    select(:id).distinct
               .joins(:categories)
               .where('categories.id' => category_ids)
  end
end
