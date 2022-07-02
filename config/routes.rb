Rails.application.routes.draw do
  devise_for :admins
  root to: 'home#index'
  resources :warehouses do
    resources :stock_product_destinations, only: [:create]
  end
  resources :suppliers, only: [:index, :show, :create, :new, :edit, :update]
  resources :product_models, only: [:index, :show, :create, :new, :edit, :update]
  resources :orders, only: [:new, :create, :show, :index, :edit, :update] do
    resources :order_items, only: [:new, :create]
    get 'search', on: :collection
    member do
      patch :delivered
      patch :canceled
    end
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: %i[show index create]
    end
  end

end
