class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name, null: false, default:""
      t.integer :price, null: false, default: 0
      t.text :description, null: false, default: ""
      t.integer :status, null: false, default: 1

      t.timestamps
    end
  end
end
