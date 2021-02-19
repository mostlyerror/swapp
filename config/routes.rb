Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  resources :clients
  resources :intakes
  resources :vouchers
  resources :swap_periods

  get "admin" => "admin/home#index"
  namespace :admin do
    get "home" => "home#index"
    put "swap_periods/:id/extend" => "swap_periods#extend", as: :extend_swap_period
  end
 
  root to: "clients#index"
end
