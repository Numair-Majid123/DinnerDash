Rails.application.routes.draw do
  resources :orders
  resources :categories 
  resources :items
  root to:"dinner#home"
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  get "dinner/cart", to: "dinner#cart", as: "cart"
  post "items/add_to_cart/:id", to: "items#add_to_cart", as: "add_to_cart"
  post "checkout/order_page", to: "checkout#order_page", as: "order_page"

  delete "items/remove_from_cart/:id", to: "items#remove_from_cart", as: "remove_from_cart"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
