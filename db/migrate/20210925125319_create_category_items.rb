# frozen_string_literal: true

class CreateCategoryItems < ActiveRecord::Migration[5.2]
  def change
    create_table :category_items do |t|
      t.integer :category_id, null: false
      t.integer :item_id, null: false

      t.timestamps
    end
  end
end
