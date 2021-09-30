# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Category.create(name: 'Fast Food')
Category.create(name: 'Chinees Food')
Category.create(name: 'Local Food')
Category.create(name: 'Drinks')
Category.create(name: 'Ice Cream')

Item.create(name: 'Biryani', description: '1 Plate', price: 100, status: 1, category_id: 3)
Item.create(name: 'Chicken Karahi', description: '1 Plate', price: 200, status: 1, category_id: 3)
Item.create(name: 'Meef biryani', description: '1 Plate', price: 300, status: 1, category_id: 3)
Item.create(name: 'Mutton Biryani', description: '1 Plate', price: 300, status: 1, category_id: 3)
Item.create(name: 'Sindhi Biryani', description: '1 Plate', price: 150, status: 1, category_id: 3)
