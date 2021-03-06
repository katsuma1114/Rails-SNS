Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "articles#index"

  resources :articles do
    resource :like, only: [:show, :create, :destroy]
    
    resources :comments, only: [:index, :create, ]
  end

  resources :accounts, only: [:show] do
    resource :follows, only: [:show, :create]
    resource :unfollows, only: [:create]

    resources :followings, only: [:index]
    resources :followers, only: [:index]
  end
  resource :profile, only: [:show, :update]
  resources :favorites, only: [:index]
  resources :timelines, only: [:index]
end
