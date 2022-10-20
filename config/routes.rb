Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :books
  resources :bookstores

  root 'inventory#index', as: 'inventory'

  get 'inventory', :action => :index, :controller => :inventory
  get 'inventory/by_bookstores/:bookstore_id/stock_level/:book_id', :as => 'stock_level', :action => :get_stock_level, :controller => :inventory
  put 'inventory/by_bookstores/:bookstore_id/stock_level/:book_id', :action => :set_stock_level, :controller => :inventory
end
