Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'pages#home'

  get "/fields/all", to: "fields#show_all", as: "fields_all"
  resources :businesses, only: [:new, :create, :index, :show]
  resources :fields, only: [:new, :show, :create, :index]
  get "/schedule", to: "fields#schedule", as: "schedule"

  resources :bookings, only: [:index, :create]
  resources :users, only: [:edit, :update]
end
