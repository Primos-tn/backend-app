Rails.application.routes.draw do
  devise_for :accounts, singular: :user # singular used to use predefiend function

  # You can have the root of your site routed with "root"
  authenticated do
    root :to => 'web/home#index'
  end

  root :to => 'web/welcome#index', :as => 'anonymous'

  get 'profile' => 'account/profiles#show' # Account::ProfilesController#index

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  post "/company/contact" => "company#contact"
  post "/business/contact" => "company#contact_business"
  # Example of regular route:
  get 'company/:page' , to: 'company#show' , as:'company_page'
  get 'business/contact'  => redirect("/company/business")

  # Example resource route within a namespace:
  namespace :dashboard do
    resources :products
    resources :brands
    resources :users
    resources :webhooks
    resources :compaings
    get 'targetize' => 'dashboard#targetize', as: :targetize
    get 'pricing/'  => "dashboard#dashboard_payment"
    get '/' , to: redirect('dashboard/products')
    get '/demo' , to: redirect('dashboard/products')
  end

  namespace :api do
    namespace :v1 do
      resources :brands do
        collection do
          get 'search'
        end
        member do
          get 'followers'
          post 'follow'
          post 'unfollow'
        end
      end

    end
  end
end
