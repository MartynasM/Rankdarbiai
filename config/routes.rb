Rails.application.routes.draw do
  devise_for :users
  resources :orders
  resources :carts
  resources :categories
  root to: "store#index", as: 'store_index'

  resources :line_items do
    get 'decrease', on: :member
    get 'increase', on: :member
  end

  resources :products
end
