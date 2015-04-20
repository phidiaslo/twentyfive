Rails.application.routes.draw do
  resources :customer_orders

  resources :cashouts

  resources :payment_notifications
  
  get 'admin' => "administration#index"
  get 'manage-services' => "administration#services"
  get 'users' => "administration#users"

  get 'dashboard' => "dashboard#index"
  get 'services' => "dashboard#services"
  get 'users' => "dashboard#users"
  get 'allorders' => "dashboard#allorders"
  get 'alllistings' => "dashboard#listings"
  get 'gigs/update_subcategories', :as => 'update_subcategories'

  ##Customer Orders##
  get 'my-purchases' => "customer_orders#purchases"
  get 'my-sales' => "customer_orders#sales"
  get 'my-earnings' => "customer_orders#earnings"
  match 'edit_customer_order_status' => "customer_orders#edit_customer_order_status", via: :post
  ###################
  
  resources :reviews

  resources :images

  resources :categories

  resources :subcategories
     
  devise_for :users

  resources :users, only: [:index, :show, :edit, :update, :destroy]

  resources :gigs, path: "", except: [:index] do
    resources :customer_orders
      collection do
        match 'search' => 'gigs#search', via: [:get, :post], as: :search
        post :edit_individual
        put :update_individual
      end
  end

  get 'privacy-policy' => "welcome#privacy"    
  #get 'offers' => "gigs#offers"

  root 'welcome#index'

end