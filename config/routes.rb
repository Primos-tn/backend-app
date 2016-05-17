Rails.application.routes.draw do
  resources :products
  resources :products
  devise_for :accounts, singular: :user # singular used to use predefiend function
  resources :profiles

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :brands
    # Example resource route (maps HTTP verbs to controller actions automatically):
    # Example resource route with options:
    resources :articles do
      collection do
         get 'search'
       end
       member do
         post 'follow'
         post 'unfollow'
       end
    end

  post "/company/contact" => "company#contact"
  post "/business/contact" => "company#contact_business"
  # Example of regular route:
  get 'company/:page' , to: 'company#show' , as:'company_page'
  get 'business/contact'  => redirect("/company/business")
  #get '*path' => 'welcome#index'


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
    namespace :dashboard do
      # Directs /admin/products/* to Admin::ProductsController
      # (app/controllers/admin/products_controller.rb)
      resources :products
      resources :brands
      get '/' , to: redirect('dashboard/products')
      get 'targetize' => 'dashboard#targetize', as: :targetize
      get 'pricing/'  => "dashboard#dashboard_payment"
    end
end
