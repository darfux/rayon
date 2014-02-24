RayonPre::Application.routes.draw do
  get "research_directions/create"
  get "research_directions/destroy"
  root to: 'sessions#new'

  get "match" => "match#index"
  get "match/get" => "match#match", as: "get_match"

  get "search" => "search#index"
  get "search_test" => "search#index_test"
  get "search/result" => "search#search", as: "search_result"
  post "search/result" => "search#search"

  # get "manage/:object" => "manage#handle"
  # get "manage" => "manage#index", as: "manage"

  get "projects/manage_list" => "projects#manage_list", as: "project_manage_list"#should before the 'resource :project'  
  get "projects/manage_tag" => "projects#manage_tag", as: "project_manage_tag"#should before the 'resource :project'
  
  get "achievements/manage_list" => "achievements#manage_list", as: "achievement_manage_list"#should before the 'resource :achievement'  
  get "achievements/manage_tag" => "achievements#manage_tag", as: "achievement_manage_tag"#should before the 'resource :achievement'
   
  get "paper/manage_list" => "papers#manage_list", as: "paper_manage_list"#should before the 'resource :paper'  
  get "paper/manage_tag" => "papers#manage_tag", as: "paper_manage_tag"#should before the 'resource :paper'
  
  resources :projects
  resources :achievements
  resources :papers
  resources :users
  resources :research_directions

  post "research_directions" => "research_directions#create", as: "create_research_direction"
  
  get "welcome" => "welcome#index", as: "welcome"
  
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
