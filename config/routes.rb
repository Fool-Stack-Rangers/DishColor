Rails.application.routes.draw do
  get 'recommendation/index'
  get 'static_pages/home'

  # root to: 'visitors#index'
  root to: 'static_pages#show'
  devise_for :users
  resources :users do
    resources :recipes, except:[:show]
  end

  get 'recipes/:id', to: "recipes#show" , as: "recipes"
end
