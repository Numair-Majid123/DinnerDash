# README

DinnerDash
    • An online commerce platform for a restaurant to facilitate online ordering.
    • It is a restaurent management application. It is used to order an item and managing it.
    • User can view items by category, order it and with previous orders.
    • Admin will manage that orders, filter it and can process orders. Create, Edit or Delete items and categories.
      
Architecture and models
    • User have many orders and one order must belongs to one user.
    • Order have many items and one item can belongs to many orders.
    • Category have many products and one product can belongs to many categories.
      
Development
    • A developer can understand this project by understanding relationship between Models, follow of application by viewing routes.
    • A developer can test application by just start rails server and sign up to the project.

Things you may want to cover:

* Ruby version '2.7.2'

* Rails version '5.2.6'

* Install important Gem using Gemfile 

* Database postgress version '13.4'

Github clone link:
 * https://github.com/Numair-Majid123/DinnerDash

 Application.yml
    CLOUD_NAME: 'test-cloud'
    CLOUD_API_KEY: 'test-api-key'
    CLOUD_API_SECRET: 'test-api-secret'

    email_user_name: 'test-email'
    email_password: 'test-password'

Folder:
    home/DinnerDash

    rails s

Link:
    http://localhost:3000/