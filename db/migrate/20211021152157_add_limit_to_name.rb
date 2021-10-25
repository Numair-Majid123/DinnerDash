# frozen_string_literal: true

class AddLimitToName < ActiveRecord::Migration[5.2]
  def up
    change_column :categories, :name, :string, limit: 32
    change_column :items, :name, :string, limit: 32
    change_column :items, :price, :decimal, precision: 6, scale: 1
  end

  def down
    change_column :categories, :name, :string
    change_column :items, :name, :string
    change_column :items, :price, :decimal
  end
end
