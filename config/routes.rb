Rails.application.routes.draw do
  get 'recommendation/index'

  get 'static_pages/home'

  # root to: 'visitors#index'
  root to: 'static_pages#show'
  devise_for :users
  resources :users
end
