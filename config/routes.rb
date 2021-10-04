# frozen_string_literal: true

Rails.application.routes.draw do
<<<<<<< HEAD
  root to: 'items#index'
=======
  resources :dinners
  resources :checkouts

  root to: 'items#index'

>>>>>>> Added Order
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :items do
    post :add_to_cart
    delete :remove_from_cart
<<<<<<< HEAD
    delete :delete_association
=======
>>>>>>> Added Order
  end

  resources :categories do
    resources :items
  end

  resources :orders do
    resources :items
    member do
      get :increase_quantity
      get :decrease_quantity
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
