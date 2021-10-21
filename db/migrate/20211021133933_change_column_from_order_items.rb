# frozen_string_literal: true

class ChangeColumnFromOrderItems < ActiveRecord::Migration[5.2]
  def change
    change_table :order_items, bulk: true do |t|
      change_column t, :order_id, :integer, null: false
      change_column t, :item_id, :integer, null: false
    end
  end
end
