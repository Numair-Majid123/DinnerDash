class Item < ApplicationRecord
    validates :name, presence: true, uniqueness: true
    has_many :category_items
    has_many :categories, through: :category_items
    accepts_nested_attributes_for :categories
end
