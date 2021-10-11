# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'items#index'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  resources :items do
    post :add_to_cart
    delete :remove_from_cart
    delete :delete_association
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

  get ("*path"), to: "orders#routes_excaption"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
