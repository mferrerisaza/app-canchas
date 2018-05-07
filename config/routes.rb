
Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'pages#home'

  resources :businesses, only: [:new, :create, :index, :show]
  resources :fields, only: [:new, :show, :create, :index]
  get "/schedule", to: "fields#schedule", as: "schedule"


  resources :bookings, only: [ :create, :show ]


end
