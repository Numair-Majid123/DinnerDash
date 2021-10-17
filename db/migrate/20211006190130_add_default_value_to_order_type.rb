# frozen_string_literal: true

class AddDefaultValueToOrderType < ActiveRecord::Migration[5.2]
  def up
    change_column :orders, :order_type, :integer, default: 0
  end

  def down
    change_column :orders, :order_type, :integer
  end
end
