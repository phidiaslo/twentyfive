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
  
  get 'purchases' => "orders#purchases"
  get 'sales' => "orders#sales"
  get 'earnings' => "orders#earnings"
  match 'edit_order_status' => "orders#edit_order_status", via: :post

  resources :reviews

  resources :images

  resources :categories

  resources :subcategories
     
  #devise_for :users, :controllers => { :registrations => :registrations }
  devise_for :users, skip: [:sessions, :passwords, :confirmations, :registrations]
  as :user do
    
    # session handling
    get     '/login'  => 'devise/sessions#new',     as: 'new_user_session'
    post    '/login'  => 'devise/sessions#create',  as: 'user_session'
    delete  '/logout' => 'devise/sessions#destroy', as: 'destroy_user_session'

    # joining
    get   '/join' => 'devise/registrations#new',    as: 'new_user_registration'
    post  '/join' => 'devise/registrations#create', as: 'user_registration'

    scope '/account' do
      # password reset
      get   '/reset-password'        => 'devise/passwords#new',    as: 'new_user_password'
      put   '/reset-password'        => 'devise/passwords#update', as: 'user_password'
      post  '/reset-password'        => 'devise/passwords#create'
      get   '/reset-password/change' => 'devise/passwords#edit',   as: 'edit_user_password'

      # confirmation
      get   '/confirm'        => 'devise/confirmations#show',   as: 'user_confirmation'
      post  '/confirm'        => 'devise/confirmations#create'
      get   '/confirm/resend' => 'devise/confirmations#new',    as: 'new_user_confirmation'

      # settings & cancellation
      get '/cancel'   => 'devise/registrations#cancel', as: 'cancel_user_registration'
      get '/settings' => 'devise/registrations#edit',   as: 'edit_user_registration'
      put '/settings' => 'devise/registrations#update'

      # account deletion
      delete '' => 'devise/registrations#destroy'
    end
  end

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