# frozen_string_literal: true

Rails.application.routes.draw do
  root 'items#index'
  devise_for :users

  resources :items do
    member do
      post :add_to_cart
      delete :remove_from_cart
      delete :delete_association
      put :update_quantity
    end
  end

  resources :categories do
    resources :items, only: %i[index]
  end

  resources :orders do
    resources :items, only: %i[index]
  end

  get '*path', to: 'orders#routes_exception'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
