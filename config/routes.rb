Rails.application.routes.draw do
  #welcome
  root 'welcome#index'

  #merchants
  resources :merchants do
    #merchant items
    resources :items, only: [:index, :new, :create], controller: :merchant_items
  end

  #items
  resources :items, except: [:new, :create] do
      #item_reviews
      resources :reviews, only: [:new, :create]
  end

  #item_reviews
  resources :reviews, only: [:edit, :update, :destroy]

  #cart
  post '/cart/:item_id', to: 'cart#add_item'
  get '/cart', to: 'cart#show'
  delete '/cart', to: 'cart#empty'
  delete '/cart/:item_id', to: 'cart#remove_item'
  patch '/cart/:item_id', to: 'cart#add_or_sub'

  #orders
  resources :orders, only: [:new, :create, :show]

  #register
  get '/register', to: 'register#new'
  post '/register', to: 'register#create'

  #login
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'

  #logout
  delete '/logout', to: 'session#destroy'

  #profile
  get '/profile', to: 'profile#show'

  #admin_user
  namespace :admin do
    get '/', to: "dashboard#show"
    get '/users', to: 'users#index'
  end

  #merchant_user
  namespace :merchant do
    get '/', to: "dashboard#show"
  end

end
