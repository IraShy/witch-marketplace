Rails.application.routes.draw do
  devise_for :users
  root to: 'products#index'
  
  resources :categories 
  resources :products
  
  get "/payments/session", to: "payments#get_stripe_id"
  get "/payments/success", to: "payments#success"
end
