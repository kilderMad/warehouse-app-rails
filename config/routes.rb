Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'
  resources :warehouses
  resources :suppliers, only: [:index, :show, :create, :new, :edit, :update]
  resources :product_models, only: [:index, :show, :create, :new, :edit, :update]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    get 'search', on: :collection
    member do
      patch :delivered
      patch :canceled
    end
  end
end
