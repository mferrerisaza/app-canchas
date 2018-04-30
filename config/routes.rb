Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :businesses, only: [:new, :create, :index, :show]
  resources :fields, only: [:new, :create, :index]


end
