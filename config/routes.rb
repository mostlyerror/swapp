Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }

  resources :clients
  
  root to: "clients#index"
end
