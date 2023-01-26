Rails.application.routes.draw do
  root 'posts#index'
  get '/login', to: 'sessions#new'
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/top", to: "static_pages#top"
  
  resources :users
  resources :posts, except: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
