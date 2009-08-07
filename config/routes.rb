ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil 
  map.forgot_password '/forgot_password', :controller => 'passwords', :action => 'new'
  map.change_password '/change_password/:reset_code', :controller => 'passwords', :action => 'reset'

  # just syntatic sugar
  map.today '/today', :controller => 'notes'

  map.resources :users, :member => { :suspend   => :put,
                                     :unsuspend => :put,
                                     :activate => :put,
                                     :purge     => :delete }, :has_many => :roles 
  map.resource :session
  map.resources :passwords
  
  map.resources :boards, :has_many => :posts
  map.resources :posts do |posts|
    posts.resources :replies
  end

  map.resources :pages, :has_many => :comments
  map.resources :notes, :has_many => :comments
  map.resources :albums, :has_many => [:photos, :comments]
  map.resources :photos, :has_many => :comments
  map.resources :assets, :member => { :download => :get }
  map.resources :events, :has_many => :comments
  
  map.resource :blog do |blog|
    blog.resources :entries
  end

  map.admin '/admin', :controller => 'admin/boards'
  map.admin_menu '/admin/menu', :controller => 'admin/menu', :action => 'edit'
  map.namespace :admin do |admin|
    admin.resources :boards
    admin.resources :users
  end

  map.root :controller => "posts", :action => 'home'
  map.connect '/:board', :controller => 'posts'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
