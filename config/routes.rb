TheBucketList::Application.routes.draw do
  # :omniauth_callbacks => "users/omniauth_callbacks"
  # devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" } do
  #     get 'users/sign_in' => 'application#about', :as => :new_user_session
  #   end
  #devise_for :users, :path => '/', :controllers => { :sessions => "sessions" }
  devise_for :users, :controllers => {:sessions => 'sessions', :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:sessions]  do
    get 'users/sign_in' => 'application#about', :as => :new_user_session
    post '/users/sign_in' => 'sessions#create'
  end
  
  # devise_for :users, :controllers => { :sessions => 'custom_devise/sessions', :omniauth_callbacks => "users/omniauth_callbacks" }, :skip => [:sessions] do
  #   get '/' => 'custom_devise/sessions#new', :as => :new_user_session
  #   #  post 'signin' => 'custom_devise/sessions#create', :as => :user_session
  #   #  get 'signout' => 'custom_devise/sessions#destroy', :as => :destroy_user_session
  #  end
  #  devise_scope :user do 
  #    match '/users/auth/facebook/callback' => 'users/omniauth_callbacks#facebook'
  #  end
  # devise_for :users, :path => "usuarios", :path_names => { :sign_in => 'login', :sign_out => 'logout', :password => 'secret', :confirmation => 'verification', :unlock => 'unblock', :registration => 'register', :sign_up => 'cmon_let_me_in' }
  # devise_for :users, :controllers => {:sessions => 'custom_devise/sessions'}, :skip => [:sessions] do
  #   get 'signin' => 'custom_devise/sessions#new', :as => :new_user_session
  #   post 'signin' => 'custom_devise/sessions#create', :as => :user_session
  #   get 'signout' => 'custom_devise/sessions#destroy', :as => :destroy_user_session
  # end
  # devise_scope :user do 
  #   match '/users/auth/facebook/callback' => 'users/omniauth_callbacks#facebook'
  #   #match "/some/route" => "some_devise_controller" 
  #    
  # end 
  #match '/auth/:provider/callback' => 'sessions#create'
  #match '/users/auth/facebook/callback' => 'users/omniauth_callback#facebook'
  # devise_scope :user do
  #      match "/users/auth/facebook/callback" => 'users/omniauth_callback#facebook'
  #   end
      
  #get '/users/auth/facebook/callback' 
  resources :goals
  post 'goals/set_sorting'
  post 'goals/rename'
  get 'about' => "application#about"
  match "timeline" => "timelines#index"
  post 'timelines/set_status' => "timelines#set_status"
  get 'timelines/progress' => "timelines#progress"
  post 'timelines/set_due_date' => 'timelines#set_due_date'
  get 'friends' => "friends#index"
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
  root :to => 'goals#index', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'application#about'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
