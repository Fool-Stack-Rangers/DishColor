Rails.application.routes.draw do
  resources :recipes

  get 'static_pages/home'

  # root to: 'visitors#index'
  root to: 'static_pages#show'
  devise_for :users
  resources :users
end
