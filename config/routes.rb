Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  resources :clients
  resources :intakes
  resources :vouchers
  get "vouchers/:id/created" => "vouchers#created", as: :voucher_created
  resources :swaps

  namespace :hotels do
    get "/", to: "home#index"
    # get "/guests/:id", to: "hotels#show"
  end

  namespace :admin do
    get "/" => "home#index", as: :home
    put "swaps/:id/extend" => "swaps#extend", as: :extend_swap
    put "swaps/:id/room_supply" => "swaps#update_room_supply", as: :update_room_supply
    get "/reports/swap" => "reports#swap", as: :swap_report
  end
 
  root to: "landing#index"
end
