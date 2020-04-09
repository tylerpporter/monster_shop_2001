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
  # NOTE: should we remain restful here? the register routes I think could be
  # changed into profile routes, like profile post and new
  get '/profile', to: 'profile#show'
  get '/profile/edit', to: 'profile#edit'
  patch '/profile', to: 'profile#update'

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
