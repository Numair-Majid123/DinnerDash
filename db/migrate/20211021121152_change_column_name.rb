# frozen_string_literal: true

class ChangeColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :order_type, :order_status
    change_column :orders, :user_id, :bigint, null: false
  end
end
