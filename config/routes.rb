Mytestapp::Application.routes.draw do
  resources :user_credits

  resources :orders

  resources :items

  resources :categories

  resources :profiles

  resources :users
  # match "login" => "users#login"
  # match "loginuser" => "users#loginuser"

  get '/login' => 'users#login', as: 'login'
  get '/shop_index' => 'users#shop_index', as: 'shop_index'
  post '/loginuser' => 'users#loginuser', as: 'loginuser'
  delete '/logout' => 'users#logout', as: 'logout'
  get '/profile_create' => 'profiles#edit', as: 'profile_create'
  get '/category_filter' => 'items#category_filter', as: 'category_filter'
  get 'purchase/:id' => 'items#purchase', as: 'purchase'
  get '/change_password' => 'users#change_password', as: 'change_password'
  get 'activation/:user_id/:user_tocken' => 'users#activation', as: 'activation'
  match 'purchase_option' => 'items#purchase_option', via: [:PATCH]
  match 'reset_password' => 'profiles#reset_password', via: [:PATCH]
  #get 'purchase/:id' => 'orders#purchase', as: 'purchase'


  #match 'purchase_option' => 'orders#purchase_option', via: [:get, :post]
   # match 'login' => 'users#login', via: [:get, :post]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'users#shop_index'

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