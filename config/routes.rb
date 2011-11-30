PET::Application.routes.draw do

  devise_for :users
  resources :users, :except => [:new, :create]
  
  match "effort_logs/does_not_overlap" => "effort_logs#does_not_overlap"
  resources :effort_logs, :except => [:index, :edit, :update, :destroy]

  match 'lifecycles/home' => 'lifecycles#home'
  resources :lifecycles, :except => [:new, :create, :edit, :destroy, :update]

  resources "project_phases"

  match 'deliverables/get_unit_of_measure' => 'deliverables#get_unit_of_measure'
  match 'deliverables/create_custom_deliverable_type' => 'deliverables#create_custom_deliverable_type'
  match 'deliverables/get_historical_data' => 'deliverables#get_historical_data'
  
  resources :deliverables, :except => [:index]
  resources :stock_deliverable_types, :has_many => :deliverables

  match 'projects/home' => 'projects#home'
  match 'phase_deliverables' => 'deliverables#show_phase_deliverables'
  
  resources :projects, :except => [:edit, :destroy, :update]

  root :to => "pages#dashboard"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "projects#home"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
