class Item < ApplicationRecord
    has_one_attached :image
    validates :name, presence: true, uniqueness: true

    has_many :category_items
    has_many :categories, through: :category_items
    
    has_many :order_items
    has_many :orders, through: :order_items
    
    accepts_nested_attributes_for :categories
end
