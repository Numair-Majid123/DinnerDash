class CategoryItem < ApplicationRecord
  # attr_accessible :category_id, :item_id
      # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    belongs_to :item
    belongs_to :category
    accepts_nested_attributes_for :item
end
