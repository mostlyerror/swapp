Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  resources :clients
  resources :intakes
  resources :vouchers
  resources :swap_periods
 
  root to: "swap_periods#index"
end
