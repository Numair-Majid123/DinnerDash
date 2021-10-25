# frozen_string_literal: true

class ChangeUserConstraint < ActiveRecord::Migration[5.2]
  def up
      change_column :users, :name, :string, null: false, limit: 32
      change_column :users, :display_name, :string, null: true, limit: 32
      change_column_default(:users, :name, nil)
      change_column_default(:users, :display_name, nil)
      change_column_default(:users, :email, nil)
    end
  end

  def down
      change_column :users, :name, :string
      change_column :users, :display_name, :string
end
