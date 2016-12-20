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
  devise_for :accounts, singular: :user,
             :controllers => {
                 :passwords => 'account/passwords',
                 :registrations => 'account/registrations',
                 :sessions => 'account/sessions'
             }


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

    resources :business, path: "business", only: [:index] do
      collection do
        get 'request-account'
        post 'create-request-account'
      end
    end


    get 'map', to: 'map#index'
    post 'company/contact'
    get 'company/:page', to: 'company#show', as: 'company_page'
    # check for not authenticated
    get 'profile', to: 'profiles#show'
    post 'profile', to: 'profiles#update'

    post 'request-join', to: 'home#create_request_join'
    get 'request-join', to: 'home#request_join'
    get 'request-pending', to: 'home'
    get 'request-join', to: 'home'

    scope :media, :controller => 'media' do
      get '/*path', to: 'media#index',  :format => false
    end

  end


  # Route
  namespace :dashboard do


    get '/' => 'dashboard#index', as: 'main'
    scope :account, controller: "accounts" do
      get 'free_trial'
      post 'free_trial'
      post 'go-free'
      get 'expired'
      get 'blocked'
      get 'upgrade-form'
      post 'upgrade'
      post 'feedback'
    end


    scope 'domain', controller: 'domain' do
      get '/' => 'domain#index'
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
    end
    resources :stores
    resources :users
    resources :api_keys, :path => '/api-keys', only: %w(index create destroy)
    resources :hooks

    resources :system, only: ['index'] do
      collection do
        patch 'update'
      end
    end

    scope :targetize, controller: 'targetize' do
      get '/(*)' => 'targetize#index'
    end

    scope :ajax, controller: 'ajax' do
      get 'info'
    end

    resources :notifications, only: %w(index show patch)

  end

  # admin routes

  namespace :admin do
    get '/' => 'base#index', as: 'main'
    get '/system' => 'system#index'
    # business configure
    get '/business/configure' => 'business_system#index'
    post '/business/configure' => 'business_system#update'
    resources :account_registration_invitations, :path => '/invitations', :controller => 'invitations', as: 'invitations' do
      member do
        patch 'confirm'
        patch 'resend'
      end
    end
    resources :business_profiles,
              only: %w(index show accept decline),
              :path => '/business-requests',
              :controller => 'business_requests',
              as: 'business_requests' do
      member do
        patch 'accept'
        patch 'decline'
      end
    end
    resources :accounts, :path => '/business', :controller => 'business_accounts', as: 'business_accounts'
    resources :categories
    resources :contacts, only: %w(index show)
    resources :brands, only: %w(index show)
    resources :accounts, only: %w(index show)
    scope :ajax, controller: 'ajax' do
      get 'info'
    end

  end


  # api routes
  namespace :api do
    namespace :v1 do
      resources :categories, only: :index

      get '/search' => 'search#index'

      scope 'geo', :controller => 'geo' do
        get 'search'
        get 'address'
        get 'mine'
      end


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
