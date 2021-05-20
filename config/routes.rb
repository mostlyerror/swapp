Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

<<<<<<< HEAD
  constraints(lambda { |req| req.env["warden"].user(:user).intake_user? }) do
=======
  constraints(lambda { |req| req.env["warden"].user(:user)&.intake_user? }) do
    get "clients/search" => "clients#search", as: :clients_search
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
    resources :clients
    resources :intakes
    resources :vouchers
    get "vouchers/:id/created" => "vouchers#created", as: :voucher_created
    resources :swaps
  end

  namespace :hotels do
<<<<<<< HEAD
    constraints(lambda { |req| req.env["warden"].user(:user).hotel_user? }) do
      get "/", to: "home#index", as: :home
    end
    get "/guests/:id" => "home#show", as: :show_client
    post "/guests/:id" => "incident_reports#create", as: :create_report
  end

  namespace :admin do
    constraints(lambda { |req| req.env["warden"].user(:user).admin_user? }) do
=======
    constraints(lambda { |req| 
      user = req.env["warden"].user(:user)
      user.hotel_user? || user.admin_user?
    }) do
      get "/", to: "home#index", as: :home
      get "/vouchers/:id" => "vouchers#show", as: :vouchers
      # get "/guests/:id" => "home#show", as: :show_client
      # post "/guests/:id" => "incident_reports#create", as: :create_report
      post "/incidents" => "incident_reports#create", as: :create_report
    end
  end

  namespace :admin do
    constraints(lambda { |req| req.env["warden"].user(:user)&.admin_user? }) do
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
      get "/" => "home#index", as: :home
      put "swaps/:id/extend" => "swaps#extend", as: :extend_swap
      put "swaps/:id/room_supply" => "swaps#update_room_supply", as: :update_room_supply
      get "/reports/swap" => "reports#swap", as: :swap_report
      put "/guests/:id" => "red_flags#edit_red_flag", as: :edit_red_flag
    end
  end
 
  root to: "landing#index"
end