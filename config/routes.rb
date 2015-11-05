Rails.application.routes.draw do


  get 'admin_users/create'

  get 'admin_users/read'

  get 'admin_users/update'

  get 'admin_users/delete'

  get 'parking_lots/update'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get '/home' => 'static_pages#home'
  get '/help' => 'static_pages#help'
  get '/about'  => 'static_pages#about'
  get '/contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get '/book_now/:id' => 'parking_lots#update' ,:as => :book_now
  get '/book_slot/:id' => 'parking_lots#update_app'
  resources :parkings
  resources :transactions
  get 'end_transaction/:id' =>'transactions#update', :as=> :end_transaction
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#home'


  # ----------------------------------  API ROUTES ----------------------------------------------- #
# http://collectiveidea.com/blog/archives/2013/06/13/building-awesome-rails-apis-part-1/
# Now our URls look like: http://api.example.com/v1/people or just http://api.example.com/people
# if you don’t use the version, it doesn’t interfere with your regular people routes, and it looks great.

namespace :api, defaults: {format: 'json'} do
  namespace :v1 do
    get 'book_now/:id' => 'parking_lots#update', :as =>:book_now_api 
    resources :parkings
    resources :transactions
    end

end

# ---------------------------------------------------------------------------------------------- #

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
