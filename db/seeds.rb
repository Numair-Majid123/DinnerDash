# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create!(name: 'Fast Food')
Category.create!(name: 'Chinees Food')
Category.create!(name: 'Local Food')
Category.create!(name: 'Drinks')
Category.create!(name: 'Ice Cream')

uploader = ImageUploader.new(:cache)
file = File.new(Rails.root.join('app/assets/images/default.png'))
uploaded_file = uploader.upload(file)
Item.create!(name: 'test Biryani', description: '1 Plate picture', price: 150, status: 0,
             image_data: uploaded_file.to_json)

file = File.new(Rails.root.join('app/assets/images/Fish-Dish.jpeg'))
uploaded_file = uploader.upload(file)
Item.create!(name: 'Karhai', description: 'karahi', price: 500, status: 1, image_data: uploaded_file.to_json)
