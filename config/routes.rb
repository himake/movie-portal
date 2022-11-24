Rails.application.routes.draw do
  root 'index#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  { class_name: 'User' }.merge(ActiveAdmin::Devise.config)
  ActiveAdmin.routes(self)

  get 'users/profile', as: 'user_root'

  resources :movies do
    resources :likes, only: [:create, :destroy]
    resources :wishes, only: [:create, :destroy]
    resources :comments
  end

  resources :serials do 
    resources :likes, only: [:create, :destroy]
    resources :wishes, only: [:create, :destroy]
    resources :comments
  end

  resources :seasons do 
    resources :likes, only: [:create, :destroy]
    resources :wishes, only: [:create, :destroy]
    resources :comments
  end

  resources :series do 
    resources :comments
  end

  resources :directors, :actors
  get 'search', to: 'search#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
