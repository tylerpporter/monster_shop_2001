Rails.application.routes.draw do

  #re-written routes
    #welcome
      get '/', to: 'welcome#index', as: :root
    #merchants
      get '/merchants', to: 'merchants#index', as: :merchants
      post '/merchants', to: 'merchants#create'
      get '/merchants/new', to: 'merchants#new', as: :new_merchant
      get '/merchants/:id/edit', to: 'merchants#edit', as: :edit_merchant
      get '/merchants/:id', to: 'merchants#show', as: :merchant
      patch '/merchants/:id', to: 'merchants#update'
      put '/merchants/:id', to: 'merchants#update'
      delete '/merchants/:id', to: 'merchants#destroy'
      #merchant_items
        get '/merchants/:merchant_id/items', to: 'merchant_items#index', as: :merchant_items
        post '/merchants/:merchant_id/items', to: 'merchant_items#create'
        get '/merchants/:merchant_id/items/new', to: 'merchant_items#new', as: :new_merchant_item
    #items
      get '/items', to: 'items#index', as: :items
      get '/items/:id', to: 'items#show', as: :item
      get '/items/:id/edit', to: 'items#edit', as: :edit_item
      patch '/items/:id', to: 'items#update'
      put '/items/:id', to: 'items#update'
      delete '/items/:id', to: 'items#destroy'
      #item_reviews
        get '/items/:item_id/reviews/new', to: 'reviews#new', as: :new_item_review
        post '/items/:item_id/reviews', to: 'reviews#create', as: :item_reviews
    #reviews
      get '/reviews/:id/edit', to: 'reviews#edit', as: :edit_review
      patch '/reviews/:id', to: 'reviews#update'
      put '/reviews/:id', to: 'reviews#update'
      delete '/reviews/:id', to: 'reviews#destroy'
    #cart
      post '/cart/:item_id', to: 'cart#add_item'
      get '/cart', to: 'cart#show', as: :cart
      delete '/cart', to: 'cart#empty'
      delete '/cart/:item_id', to: 'cart#remove_item'
      patch '/cart/:item_id', to: 'cart#add_or_sub'
    #orders
      get '/orders/new', to: 'orders#new', as: :new_order
      get '/orders/:id', to: 'orders#show', as: :order
      post '/orders', to: 'orders#create', as: :orders
      patch '/orders/:id', to: 'orders#update'
      put'/orders/:id', to: 'orders#update'
    #register
      get '/register', to: 'register#new', as: :register
      post '/register', to: 'register#create'
    #login
      get '/login', to: 'session#new', as: :login
      post '/login', to: 'session#create'
    #logout
      delete '/logout', to: 'session#destroy', as: :logout
    #password
      get '/password/edit', to: 'passwords#edit', as: :edit_password
      patch '/password', to: 'passwords#update', as: :password
      put '/password', to: 'passwords#update'
    #profile
      get '/profile', to: 'profile/dashboard#show', as: :profile
      get '/profile/edit', to: 'profile/dashboard#edit', as: :profile_edit
      patch '/profile', to: 'profile/dashboard#update'
      #orders
        get '/profile/orders', to: 'profile/orders#index', as: :profile_orders
        get '/profile/orders/:id', to: 'profile/orders#show', as: :profile_order
        patch '/profile/orders/:id', to: 'profile/orders#update'
        put '/profile/orders/:id', to: 'profile/orders#update'
    #admin
      get '/admin', to: 'admin/dashboard#show', as: :admin
      #merchants
        get '/admin/merchants', to: 'admin/merchants#index', as: :admin_merchants
        get '/admin/merchants/:id', to: 'admin/merchants#show', as: :admin_merchant
        patch '/admin/merchants/:id', to: 'admin/merchants#update'
        put '/admin/merchants/:id', to: 'admin/merchants#update'
      #user
        get '/admin/users', to: 'admin/users#index', as: :admin_users
        get '/admin/users/:id', to: 'admin/users#show', as: :admin_user
    #merchant
      get '/merchant', to: 'merchant/dashboard#show'
      # orders
        get '/merchant/orders/:id', to: 'merchant/orders#show'
      # items
        get '/merchant/items', to: 'merchant/items#index'
        get '/merchant/items/new', to: 'merchant/items#new'
        get '/merchant/items/:id/edit', to: 'merchant/items#edit', as: :edit_merchant_item
        post '/merchant/items', to: 'merchant/items#create'
        patch '/merchant/items/:id', to: 'merchant/items#update', as: :merchant_item
        put '/merchant/items/:id', to: 'merchant/items#update'
        delete '/merchant/items/:id', to: 'merchant/items#destroy'
      # item_orders
        patch '/merchant/item_orders/:id', to: 'merchant/item_orders#update', as: :merchant_item_order
        put '/merchant/item_orders/:id', to: 'merchant/item_orders#update'
  #end

  #ORIGINAL ROUTES
    #welcome
    # root 'welcome#index'
    #
    # #merchants
    # resources :merchants do
    #   #merchant items
    #   resources :items, only: [:index, :new, :create], controller: :merchant_items
    # end

    #items
    # resources :items, except: [:new, :create] do
    #     #item_reviews
    #     resources :reviews, only: [:new, :create]
    # end

    #item_reviews
    # resources :reviews, only: [:edit, :update, :destroy]

    #cart
    # post '/cart/:item_id', to: 'cart#add_item'
    # get '/cart', to: 'cart#show'
    # delete '/cart', to: 'cart#empty'
    # delete '/cart/:item_id', to: 'cart#remove_item'
    # patch '/cart/:item_id', to: 'cart#add_or_sub'

    #orders
    # resources :orders, only: [:new, :create, :show, :update]

    #register
    # get '/register', to: 'register#new'
    # post '/register', to: 'register#create'

    #login
    # get '/login', to: 'session#new'
    # post '/login', to: 'session#create'

    #logout
    # delete '/logout', to: 'session#destroy'

    #password_reset
    # resource :password, only: [:edit, :update]

    # namespace :profile, resources: :profile do
    #   resources :orders, only: [:index, :show, :update]
    #   get '/', to: 'dashboard#show'
    #   get '/edit', to: 'dashboard#edit'
    #   patch '/', to: 'dashboard#update'
    # end

    #admin_user
    # namespace :admin do
    #   get '/', to: 'dashboard#show'
    #   resources :merchants, only: [:index, :show, :update]
    #   resources :users, only: [:index, :show]
    # end

    #merchant_user
    # namespace :merchant do
    #   get '/', to: 'dashboard#show'
    #   get '/orders/:id', to: 'orders#show'
    #   resources :items, except: [:show]
    #   resources :item_orders, only: [:update]
    # end
  #end
  
end
