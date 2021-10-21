# frozen_string_literal: true

class AddForeignKeyToItems < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :orders, :users
    add_foreign_key :order_items, :orders
    add_foreign_key :order_items, :items
    add_foreign_key :category_items, :items
    add_foreign_key :category_items, :categories
  end
end
