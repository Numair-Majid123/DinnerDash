# frozen_string_literal: true

class AddImageToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :image_data, :text
  end
end
