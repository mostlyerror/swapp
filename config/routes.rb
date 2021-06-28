Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  put "users/:id/settings" => "settings#update"

  post 'messages/sms'
  resource :messages do
    collection do 
      post 'reply'
    end
  end

  constraints(lambda do |req| 
    user = req.env["warden"].user(:user)
    user.active? && (user.intake_user? || user.admin_user?)
  end) do
    get "clients/search" => "clients#search", as: :clients_search
    resources :clients
    resources :intakes
    resources :vouchers
    get "vouchers/:id/created" => "vouchers#created", as: :voucher_created
    post "voucher/:id/send_voucher" => "vouchers#send_voucher", as: :send_voucher
    resources :swaps
  end

  namespace :hotels do
    constraints(lambda { |req| 
      user = req.env["warden"].user(:user)
      user.active? && (user.hotel_user? || user.admin_user?)
    }) do
      get "/", to: "home#index", as: :home
      get "/vouchers/:id" => "vouchers#show", as: :vouchers
      post "/incidents" => "incident_reports#create", as: :create_report
    end
  end

  namespace :admin do
    constraints(lambda { |req| 
      user = req.env["warden"].user(:user)
      user.active? && user.admin_user?
    }) do
      get "/" => "home#index", as: :home
      get "/users" => "users#index", as: :users
      put "users/:id" => "users#update"
      get "clients/search" => "clients#search", as: :clients_search
      get "/home/clients/:id" => "clients#show", as: :clients
      post "swaps" => "swaps#create"
      put "swaps/:id/extend" => "swaps#extend", as: :extend_swap
      put "swaps/:id/room_supply" => "swaps#update_room_supply", as: :update_room_supply
      get "/reports/swap" => "reports#swap", as: :swap_report
      put "/guests/:id" => "red_flags#edit_red_flag", as: :edit_red_flag
      post "clients/:id/incidents" => "incident_reports#create", as: :create_incident_report
    end
  end
 
  root to: "landing#index"
end