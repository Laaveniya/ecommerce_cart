Rails.application.routes.draw do
  resources :products
  resources :carts do
    collection do
      put :add_items
      get :checkout
    end
  end
end
