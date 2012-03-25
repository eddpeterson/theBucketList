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
  get 'terms-of-service' => 'application#terms'
  
  match "timeline" => "timelines#index"
  post 'timelines/set_status' => "timelines#set_status"
  get 'timelines/progress' => "timelines#progress"
  post 'timelines/set_due_date' => 'timelines#set_due_date'
  
  get 'friends' => "friends#index"

  root :to => 'goals#index', :constraints => lambda {|r| r.env["warden"].authenticate? }
  root :to => 'application#about'
  
end