Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'
  resources :warehouses
  resources :suppliers, only: [:index, :show, :create, :new, :edit, :update]
  resources :product_models, only: [:index, :show, :create, :new, :edit, :update]
end
