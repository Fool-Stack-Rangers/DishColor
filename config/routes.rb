Rails.application.routes.draw do
  authenticated :user do
    root to: 'recommendation#index', as: :recommendation
  end
  root to: 'static_pages#show'

  get 'static_pages/home'

  # root to: 'visitors#index'
  devise_for :users
  resources :users do
    resources :recipes, except:[:show]
  end

  resources :lists, only:[:index, :show, :create]

  get 'recipes/:id', to: "recipes#show" , as: "recipes"

  get 'get_dish/:colors',to: "recipes#getDish", defaults: { format: 'json' }
end
