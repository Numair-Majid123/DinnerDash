class Category < ApplicationRecord
    validates :name, presence: true
    has_many :category_items
    has_many :items, through: :category_items
    accepts_nested_attributes_for :items
end
