KingstonApp::Application.routes.draw do

  get "activities/new"
  get "activities/index"

  # Map to HTTP Requests
  resources :users
	resources :sessions, :only => [:new, :create, :destroy]
	resources :posts
	resources :memberships
	resources :subscriptions
	resources :activities

  get "users/index"
  get "users/show"
  get "users/new"
  get "users/edit"

  get "pages/index"
  get "pages/about"
  get "pages/contact"
  get "pages/terms"
  get "pages/help"
  
  get "posts/new"
  get "memberships/new"
  get "memberships/show"
   
  get "swimming/new"
  get "swimming/index"
  
  # creating a route through the pages controller actions
  match '/about' 	 => 'pages#about'
  match '/contact' => 'pages#contact'
  match '/help' 	 => 'pages#help'
  match '/tos' 	 	 => 'pages#terms'
  
  
  match '/signup'  => 'users#new'
  match '/signout' => 'sessions#destroy' # destroy action to delete cookie
  match '/signin'  => 'sessions#new' # new action to render signin form
  
  #Example Purchase
  match '/memberships/:id/purchase' => 'users#purchase_membership', :as => :purchase_membership

	match '/memberships/:id/cancel' => 'users#cancel_membership', :as => :cancel_membership
	
	match '/swimming/:id/booking' => 'users#swimming_booking', :as => :book_swimming
	
	match '/swimming/:id/booking' => 'users#cancel_booking', :as => :cancel_swimming

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
  # root :to => "welcome#index"
  
  root :to => 'pages#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
