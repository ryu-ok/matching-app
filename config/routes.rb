Rails.application.routes.draw do
  devise_for :users
  root 'users#index'
  resources :users, only: [:edit, :update, :show] do
    member do
      get "match_list"
      get "follower_list"
    end
  end
  resources :relationships, only: [:create, :destroy]
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
