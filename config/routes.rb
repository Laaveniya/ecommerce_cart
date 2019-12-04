# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products
  resources :shopping_carts do
    put :checkout, on: :member
  end

  resources :order_items
end
