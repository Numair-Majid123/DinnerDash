class AddDefaultValueToOrderType < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :order_type, :string, default: 'Ordered'
  end
end
