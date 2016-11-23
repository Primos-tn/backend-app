Rails.application.routes.draw do

  devise_for :accounts, singular: :user # singular used to use predefiend function

  # You can have the root of your site routed with "root"
  authenticated do
    root :to => 'web/home#index'
  end

  root :to => 'web/welcome#index', :as => 'anonymous'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:

  scope :module => 'web' do
    resources :products,  only: %w(index show) do
      member do
        get 'stores'
        get 'reviews'
        get 'wishers'
        get 'coupons'
      end
    end
    resources :brands, only: %w(index show) do
      member do
        get 'stores'
        get 'reviews'
        get 'followers'
        get 'info'
        get 'products'
        get 'stores'
      end
    end

    get 'map', to: 'map#index'
    get 'company/:page', to: 'company#show' , as:'company_page'
    # check for not authenticated
    get 'profile', to: 'profiles#show'
  end


  # Route
  namespace :dashboard do
    resources :products do
      member do
        post 'launch'
      end
      resources :targetize, only: :index
    end

    resources :brand_team_members , as: 'team', path: 'team'  do
      member do
        post 'set-admin'
      end
      collection do
        post 'invite'
      end
    end

    resources :brands do
        collection do
          get 'select'
          post 'select'
        end
        member do
          post 'upload'
        end
        resources :brand_stores, :path => '/brand-stores'
    end
    resources :users
    resources :api_keys, :path => '/api-keys', only: ['index', 'create', 'destroy']
    resources :hooks

    get '/demo(/:page)'  => 'demo#index'
    get '/'  => 'dashboard#index', as: 'main'

    resources :system, only: ['index']

  end

  # admin routes

  namespace :admin do
    get '/'  => 'base#index', as: 'main'
    get '/system'  => 'system#index'
    resources :categories
    resources :brands, only: ['index', 'show']
    resources :accounts, only: ['index', 'show']

  end



  # api routes
  namespace :api do
    namespace :v1 do
      resources :categories , only: :index

      get '/search'  => 'search#index'

      resources :products do
        collection do
          get 'search'
        end
        member do
          # share
          get 'share'
          # wishers api
          get 'wishers'
          # product reviews api
          get 'reviews'
          # wish a product
          post 'wish'
          # unwish
          post 'unwish'
          # unwish
          post 'review'
          #
          get 'coupons'
          # notify me
          post 'notify'
        end
      end

      resources :users do
        member do
          get 'followers'
          get 'brands'
          get 'whishes'
          post 'follow'
          post 'unfollow'
        end
      end

      resources :brands do
        collection do
          get 'search'
        end
        member do
          get 'followers'
          post 'follow'
          post 'unfollow'
          post 'review'
          get 'stores'
          get 'reviews'
          get 'followers'
          get 'info'
          get 'stores'
        end
      end

    end
  end



end
