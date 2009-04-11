ActionController::Routing::Routes.draw do |map|
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
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  
  # See how all your routes lay out with "rake routes"
  
  map.connect '/',
    :controller => 'welcome', :action => 'index',
    :conditions => {
      :host        => Rails.configuration.announce.tlds,
      :method      => :get}
      
  map.connect '/',
    :controller => 'teasers', :action => 'show',
    :conditions => {
      :subdomain => Account.subdomain_regex,
      :method    => :get}
  map.teaser '/teaser/:subscriber_id',
    :controller => 'teasers', :action => 'show',
    :defaults => {:subscriber_id => nil},
    :requirements => {:subscriber_id => /\d+/},
    :conditions => {:method => :get}
    
  map.template_styles '/templates/:id/styles.css',
    :controller => 'templates', :action => 'styles',
    :requirements => {:id => /\d+/},
    :conditions => {:method => :get}
    
  map.connect '/subscribe',
    :controller => 'teasers', :action => 'subscribe',
    :conditions => { :method => :post }
    
  map.signup '/signup', :controller => 'accounts', :action => 'new'
  map.preferences '/preferences',
    :controller => 'accounts', :action => 'edit',
    :conditions => {
      :method => :get
    }
    
  map.login  '/login',  :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.admin_dashboard '/dashboard',
    :controller => 'admin/statistics', :action => 'show',
    :conditions => {:method => :get}
    
  map.namespace :admin, :path_prefix => '' do |admin|
    admin.resource  :statistics, :member => { :graph => :get }
    admin.resources :subscribers
    admin.resource  :teaser
    admin.resource  :domain
  end
  
  map.resources :accounts
  map.resource :session
  
  map.root :controller => 'welcome', :action => 'index'
end
