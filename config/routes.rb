Rails.application.routes.draw do
  resources :clients
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "clients#index"
end
