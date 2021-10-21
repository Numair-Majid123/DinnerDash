# frozen_string_literal: true

class ChangeUserConstraint < ActiveRecord::Migration[5.2]
  def up
    change_table :users, bulk: true do |t|
      change_column t, :name, :string, null: false, limit: 32
      change_column t, :display_name, :string, limit: 32
      change_column t, :display_name, :string, null: true
      change_column_default(t, :name, nil)
      change_column_default(t, :display_name, nil)
      change_column_default(t, :email, nil)
    end
  end

  def down
    change_table :users, bulk: true do |t|
      change_column t, :name, :string
      change_column t, :display_name, :string
    end
  end
end
