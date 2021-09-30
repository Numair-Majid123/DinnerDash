# frozen_string_literal: true

Rails.application.routes.draw do
  resources :orders
  resources :items
  resources :categories do
    resources :items
  end
  resources :dinners
  resources :checkouts
  root to: 'dinners#home'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  post 'items/add_to_cart/:id', to: 'items#add_to_cart', as: 'add_to_cart'
  delete 'items/remove_from_cart/:id', to: 'items#remove_from_cart', as: 'remove_from_cart'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
