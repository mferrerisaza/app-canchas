Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :businesses, only: [:new, :create, :index, :show]
  resources :fields, only: [:new, :show, :create, :index]
  get "/schedule", to: "fields#schedule", as: "schedule"

end
