Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  constraints(lambda { |req| req.env["warden"].user(:user)&.intake_user? }) do
    resources :clients
    resources :intakes
    resources :vouchers
    get "vouchers/:id/created" => "vouchers#created", as: :voucher_created
    resources :swaps
  end

  namespace :hotels do
    constraints(lambda { |req| req.env["warden"].user(:user)&.hotel_user? }) do
      get "/", to: "home#index", as: :home
    end
  end

  namespace :admin do
    constraints(lambda { |req| req.env["warden"].user(:user)&.admin_user? }) do
      get "/" => "home#index", as: :home
      put "swaps/:id/extend" => "swaps#extend", as: :extend_swap
      put "swaps/:id/room_supply" => "swaps#update_room_supply", as: :update_room_supply
      get "/reports/swap" => "reports#swap", as: :swap_report
    end
  end
 
  root to: "landing#index"
end