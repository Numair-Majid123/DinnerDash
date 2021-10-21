# frozen_string_literal: true

class AddIndexToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_index :order_items, :order_id
    add_index :order_items, :item_id
  end
end
