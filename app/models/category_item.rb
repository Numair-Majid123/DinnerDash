# frozen_string_literal: true

class CategoryItem < ApplicationRecord
  belongs_to :item
  belongs_to :category

  accepts_nested_attributes_for :item
end
