# frozen_string_literal: true

class ChangeColumnFromItems < ActiveRecord::Migration[5.2]
  def up
      change_column_default(:items, :name, nil)
      change_column_default(:items, :description, nil)
      change_column_default(:categories, :name, nil)
  end

  def down
      change_column :items, :name, default: ''
      change_column :items, :description, default: ''
      change_column :categories, :name, default: ''
  end
end
