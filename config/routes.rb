Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  
  resources :categories 
  resources :products
  resources :orders, only: [:create, :show]
  
  get "/payments/session", to: "payments#get_stripe_id"
  get "/payments/success", to: "payments#success"
  post "/payments/webhook", to: "payments#webhook"
  get '/dashboard', to: 'profiles#dashboard'
end
