Rails.application.routes.draw do
  resources :clients
  devise_for :users, controllers: {
    sessions: 'sessions/sessions'
  }
  
  root to: "clients#index"
end
