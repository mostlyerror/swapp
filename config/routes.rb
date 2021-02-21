Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  resources :clients
  resources :intakes
  resources :vouchers
  get "vouchers/:id/created" => "vouchers#created"
  resources :swap_periods

  # get "admin" => "admin/home#index"
  namespace :admin do
    get "/" => "home#index", as: :home
    put "swap_periods/:id/extend" => "swap_periods#extend", as: :extend_swap_period
  end
 
  root to: "clients#index"
end
