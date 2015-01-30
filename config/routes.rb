Rails.application.routes.draw do
  get 'static_pages/home'

  # root to: 'visitors#index'
  root to: 'static_pages#show'
  devise_for :users
  resources :users
end
