SpecialOlympicsApplication::Application.routes.draw do

  resources :teachers

  resources :groups

  get "heat_sheet_generator/index"
  get '/index/heat_sheet_generator', to: 'heat_sheet_generator#index'
  get '/index/heats', to: 'heats#index'
  get '/index/athletes', to: 'athletes#index'
  get '/index/events', to: 'events#index'
  get '/index/groups', to: 'groups#index'

  resources :heat_sheet_generator do
    member {get "download"}
  end

  get '/heatsheets/download', to: 'heat_sheet_generator#download'

  resources :teachers do
    collection {post :import}
  end

  resources :groups do
    collection { post :import }
  end

  resources :athletes do
    collection { post :import }
  end
  
  resources :heats do 
    collection { post :import }
  end

  resources :events do
    collection { post :import }
  end

  root 'welcome#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
