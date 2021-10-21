# frozen_string_literal: true

class ChangeColumnFromItems < ActiveRecord::Migration[5.2]
  def up
    change_table :items, bulk: true do |t|
      change_column_default(t, :name, nil)
      change_column_default(t, :description, nil)
      change_column_default(:categories, :name, nil)
    end
  end

  def down
    change_table :items, bulk: true do |t|
      change_column t, :name, default: ''
      change_column t, :description, default: ''
      change_column :categories, :name, default: ''
    end
  end
end
