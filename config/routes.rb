Rails.application.routes.draw do

  match '/user/join_new_room', to: 'users#join_new_room', via: :get
  match '/user/join_room', to: 'users#join_room', via: :post
  match '/rooms/score' , to: 'rooms#update_score' , via: :get
  match '/rooms/update_score' , to: 'rooms#update_new_score' , via: :post
  match '/rooms/reset', to: 'rooms#reset_room', via: :post

  resources :rooms
  get 'game/decks'
  # for play cards
  match '/rooms/play_card', to: 'rooms#play_card', via: :post
  # to discard cards
  match '/discard/discard_card', to: 'discard#discard_card', via: :post

  match '/discard/index', to: 'discard#index', via: :get

  resources :users
  match '/login', to: 'sessions#new', via: :get
  match '/login_create', to: 'sessions#create', via: :post
  match '/logout', to: 'sessions#destroy', via: :delete

  match '/room_del', to: 'rooms#destroy', via: :delete
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  root 'sessions#new'

  # for cards
  match '/user/draw' , to: 'users#draw_card', via: :post
  match '/user/trade' , to: 'users#trade_card', via: :post

  match '/trade/index' , to: 'trade#index', via: :get

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
