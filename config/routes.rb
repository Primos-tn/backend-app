Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  authenticated do
    root :to => 'web/home#index'
  end

  root :to => 'web/welcome#index', :as => 'anonymous'

  # handle account
  # check fo devise_scope method to show how to handle
  devise_scope :user do
    get 'accounts/settings', :to => 'devise/registrations#edit'
  end
  devise_for :accounts, singular: :user, :controllers => {:passwords => "account/passwords", :registrations => "account/registrations"}


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # Example of regular route:

  scope :module => 'web' do
    resources :products, only: %w(index show) do
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

    resources :business, path: "business", only: :index do
      collection do
        post 'request'
        get 'request'
      end
    end
    get 'map', to: 'map#index'
    post 'company/contact'
    get 'company/:page', to: 'company#show', as: 'company_page'
    # check for not authenticated
    get 'profile', to: 'profiles#show'
    post 'profile', to: 'profiles#update'
  end


  # Route
  namespace :dashboard do

    scope :account, controller: "accounts" do
      post 'go-free'
      get 'expired'
      post 'upgrade'
      get 'upgrade-form'
      post 'pay'
    end

    resources :products do
      member do
        post 'launch'
      end
      resources :targetize, only: :index
    end

    resources :brand_team_members, as: 'team', path: 'team' do
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
      resources :stores, :path => '/brand-stores'
    end
    resources :users
    resources :api_keys, :path => '/api-keys', only: %w(index create destroy)
    resources :hooks

    get '/' => 'dashboard#index', as: 'main'

    resources :targetize, only: ['index']
    resources :system, only: ['index']

  end

  # admin routes

  namespace :admin do
    get '/' => 'base#index', as: 'main'
    get '/system' => 'system#index'
    get '/business/configure' => 'business#index'
    post '/business/configure' => 'business#update'
    resources :account_registration_invitations, :path => '/invitations', :controller => 'invitations', as: 'invitations'
    resources :business_profiles, :path => '/business', :controller => 'business'
    resources :categories
    resources :brands, only: %w(index show)
    resources :accounts, only: %w(index show)

  end


  # api routes
  namespace :api do
    namespace :v1 do
      resources :categories, only: :index

      get '/search' => 'search#index'

      resources :products do
        collection do
          get 'search'
          get 'product-of-day'
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
