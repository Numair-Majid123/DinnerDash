# README

DinnerDash
    An online commerce platform for a restaurant to facilitate online ordering.

    It is a restaurent management application. It is used to order an item and managing it.
    User can view items by category, order it and with previous orders.
    Admin will manage that orders, filter it and can process orders. Create, Edit or Delete items and categories.

Architecture and models
    User have many orders and one order must belongs to one user.
    Order have many items and one item can belongs to many orders.
    Category have many products and one product can belongs to many categories.

Development
    A developer can under this project by understanding relationship between Models, follow of application by viewing routes.
    A developer can test application by just start rails server and sign up to the project.

Key Feature for Admin Role
    Create item listings including a name, description, price, and upload a photo
    Modify existing items’ name, description, price, and photo
    Create named categories for items (eg: "Lahori Food")
    Assign items to categories or remove them from categories. Products can belong to more than one category.
    Retire a item from being sold, which hides it from browsing by any non-administrator
    the total number of orders by status
    links for each individual order
    filter orders to display by status type (for statuses "ordered", "paid", "cancelled", "completed")
    link to transition to a different status:
    link to "cancel" individual orders which are currently "ordered" or "paid"
    link to "mark as paid" orders which are "ordered"
    link to "mark as completed" individual orders which are currently "paid"

Key Feature for Unauthenticated user
    Browse all items
    Browse items by category
    Add an item to my cart
    View my cart
    Remove an item from my cart
    Increase the quantity of a item in my cart

Key Feature for Simple user
    Do everything Unauthenticated Users can do except "log in"
    log out
    view their past orders with links to display each order
    on that order display page there are:
    items with quantity ordered and line-item subtotals
    links to each item description page
    the current status of the order
    order total price
    date/time order was submitted
    if completed or cancelled, display a timestamp when that action took place





Things you may want to cover:

* Ruby version '2.7.2'

* Rails version '5.2.6'

* Install important Gem using Gemfile 