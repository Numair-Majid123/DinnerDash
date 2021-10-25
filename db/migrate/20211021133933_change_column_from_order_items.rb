# frozen_string_literal: true

class ChangeColumnFromOrderItems < ActiveRecord::Migration[5.2]
  def change
      change_column :order_items, :order_id, :integer, null: false
      change_column :order_items, :item_id, :integer, null: false
  end
end
