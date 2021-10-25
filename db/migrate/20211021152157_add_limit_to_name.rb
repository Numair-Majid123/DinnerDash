# frozen_string_literal: true

class AddLimitToName < ActiveRecord::Migration[5.2]
  def up
    change_table :items, bulk: true do |t|
      change_column :categories, :name, :string, limit: 32
      change_column t, :name, :string, limit: 32
      change_column t, :price, :decimal, precision: 6, scale: 1
    end
  end

  def down
    change_table :items, bulk: true do |t|
      change_column :categories, :name, :string
      change_column t, :name, :string
      change_column t, :price, :decimal
    end
  end
end
