class CategoryItem < ApplicationRecord
  # attr_accessible :category_id, :item_id

    belongs_to :item
    belongs_to :category
    accepts_nested_attributes_for :item
end
