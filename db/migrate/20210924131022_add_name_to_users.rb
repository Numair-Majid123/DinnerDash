# frozen_string_literal: true

class AddNameToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string, null: false, default: ''
    add_column :users, :display_name, :string, null: false, default: ''
  end
end
