# frozen_string_literal: true

class AddIndexToCategoryItems < ActiveRecord::Migration[5.2]
  def change
    add_index :category_items, :category_id
    add_index :category_items, :item_id
  end
end
