# == Route Map
#
#                                Prefix Verb   URI Pattern                                                                              Controller#Action
#                      new_user_session GET    /users/sign_in(.:format)                                                                 sessions/sessions#new
#                          user_session POST   /users/sign_in(.:format)                                                                 sessions/sessions#create
#                  destroy_user_session DELETE /users/sign_out(.:format)                                                                sessions/sessions#destroy
#                     new_user_password GET    /users/password/new(.:format)                                                            devise/passwords#new
#                    edit_user_password GET    /users/password/edit(.:format)                                                           devise/passwords#edit
#                         user_password PATCH  /users/password(.:format)                                                                devise/passwords#update
#                                       PUT    /users/password(.:format)                                                                devise/passwords#update
#                                       POST   /users/password(.:format)                                                                devise/passwords#create
#              cancel_user_registration GET    /users/cancel(.:format)                                                                  devise/registrations#cancel
#                 new_user_registration GET    /users/sign_up(.:format)                                                                 devise/registrations#new
#                edit_user_registration GET    /users/edit(.:format)                                                                    devise/registrations#edit
#                     user_registration PATCH  /users(.:format)                                                                         devise/registrations#update
#                                       PUT    /users(.:format)                                                                         devise/registrations#update
#                                       DELETE /users(.:format)                                                                         devise/registrations#destroy
#                                       POST   /users(.:format)                                                                         devise/registrations#create
#                                       PUT    /users/:id/settings(.:format)                                                            settings#update
#                          messages_sms POST   /messages/sms(.:format)                                                                  messages#sms
#                        reply_messages POST   /messages/reply(.:format)                                                                messages#reply
#                          new_messages GET    /messages/new(.:format)                                                                  messages#new
#                         edit_messages GET    /messages/edit(.:format)                                                                 messages#edit
#                              messages GET    /messages(.:format)                                                                      messages#show
#                                       PATCH  /messages(.:format)                                                                      messages#update
#                                       PUT    /messages(.:format)                                                                      messages#update
#                                       DELETE /messages(.:format)                                                                      messages#destroy
#                                       POST   /messages(.:format)                                                                      messages#create
#                        clients_search GET    /clients/search(.:format)                                                                clients#search
#                               clients GET    /clients(.:format)                                                                       clients#index
#                                       POST   /clients(.:format)                                                                       clients#create
#                            new_client GET    /clients/new(.:format)                                                                   clients#new
#                           edit_client GET    /clients/:id/edit(.:format)                                                              clients#edit
#                                client GET    /clients/:id(.:format)                                                                   clients#show
#                                       PATCH  /clients/:id(.:format)                                                                   clients#update
#                                       PUT    /clients/:id(.:format)                                                                   clients#update
#                                       DELETE /clients/:id(.:format)                                                                   clients#destroy
#                               intakes GET    /intakes(.:format)                                                                       intakes#index
#                                       POST   /intakes(.:format)                                                                       intakes#create
#                            new_intake GET    /intakes/new(.:format)                                                                   intakes#new
#                           edit_intake GET    /intakes/:id/edit(.:format)                                                              intakes#edit
#                                intake GET    /intakes/:id(.:format)                                                                   intakes#show
#                                       PATCH  /intakes/:id(.:format)                                                                   intakes#update
#                                       PUT    /intakes/:id(.:format)                                                                   intakes#update
#                                       DELETE /intakes/:id(.:format)                                                                   intakes#destroy
#                              vouchers GET    /vouchers(.:format)                                                                      vouchers#index
#                                       POST   /vouchers(.:format)                                                                      vouchers#create
#                           new_voucher GET    /vouchers/new(.:format)                                                                  vouchers#new
#                          edit_voucher GET    /vouchers/:id/edit(.:format)                                                             vouchers#edit
#                               voucher GET    /vouchers/:id(.:format)                                                                  vouchers#show
#                                       PATCH  /vouchers/:id(.:format)                                                                  vouchers#update
#                                       PUT    /vouchers/:id(.:format)                                                                  vouchers#update
#                                       DELETE /vouchers/:id(.:format)                                                                  vouchers#destroy
#                       voucher_created GET    /vouchers/:id/created(.:format)                                                          vouchers#created
#                          send_voucher POST   /voucher/:id/send_voucher(.:format)                                                      vouchers#send_voucher
#                                 swaps GET    /swaps(.:format)                                                                         swaps#index
#                                       POST   /swaps(.:format)                                                                         swaps#create
#                              new_swap GET    /swaps/new(.:format)                                                                     swaps#new
#                             edit_swap GET    /swaps/:id/edit(.:format)                                                                swaps#edit
#                                  swap GET    /swaps/:id(.:format)                                                                     swaps#show
#                                       PATCH  /swaps/:id(.:format)                                                                     swaps#update
#                                       PUT    /swaps/:id(.:format)                                                                     swaps#update
#                                       DELETE /swaps/:id(.:format)                                                                     swaps#destroy
#                           hotels_home GET    /hotels(.:format)                                                                        hotels/home#index
#                       hotels_vouchers GET    /hotels/vouchers/:id(.:format)                                                           hotels/vouchers#show
#                  hotels_create_report POST   /hotels/incidents(.:format)                                                              hotels/incident_reports#create
#                            admin_home GET    /admin(.:format)                                                                         admin/home#index
#                           admin_users GET    /admin/users(.:format)                                                                   admin/users#index
#                                 admin PUT    /admin/users/:id(.:format)                                                               admin/users#update
#                  admin_clients_search GET    /admin/clients/search(.:format)                                                          admin/clients#search
#                         admin_clients GET    /admin/home/clients/:id(.:format)                                                        admin/clients#show
#                           admin_swaps POST   /admin/swaps(.:format)                                                                   admin/swaps#create
#                                       PUT    /admin/swaps/:id/update(.:format)                                                        admin/swaps#update
#                     admin_extend_swap PUT    /admin/swaps/:id/extend(.:format)                                                        admin/swaps#extend
#              admin_update_room_supply PUT    /admin/swaps/:id/room_supply(.:format)                                                   admin/swaps#update_room_supply
#                     admin_swap_report GET    /admin/reports/swap(.:format)                                                            admin/reports#swap
#                   admin_edit_red_flag PUT    /admin/guests/:id(.:format)                                                              admin/red_flags#edit_red_flag
#          admin_create_incident_report POST   /admin/clients/:id/incidents(.:format)                                                   admin/incident_reports#create
#                                  root GET    /                                                                                        landing#index
#         rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                  action_mailbox/ingresses/postmark/inbound_emails#create
#            rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                     action_mailbox/ingresses/relay/inbound_emails#create
#         rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                  action_mailbox/ingresses/sendgrid/inbound_emails#create
#   rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#health_check
#         rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                  action_mailbox/ingresses/mandrill/inbound_emails#create
#          rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                              action_mailbox/ingresses/mailgun/inbound_emails#create
#        rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#index
#                                       POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                 rails/conductor/action_mailbox/inbound_emails#create
#     new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                             rails/conductor/action_mailbox/inbound_emails#new
#    edit_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id/edit(.:format)                        rails/conductor/action_mailbox/inbound_emails#edit
#         rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#show
#                                       PATCH  /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       PUT    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#update
#                                       DELETE /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                             rails/conductor/action_mailbox/inbound_emails#destroy
# rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                      rails/conductor/action_mailbox/reroutes#create
#                    rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#             rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#                    rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#             update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#                  rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

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
      put "swaps/:id/update" => "swaps#update"
      put "swaps/:id/extend" => "swaps#extend", as: :extend_swap
      put "swaps/:id/room_supply" => "swaps#update_room_supply", as: :update_room_supply
      get "/reports/swap" => "reports#swap", as: :swap_report
      put "/guests/:id" => "red_flags#edit_red_flag", as: :edit_red_flag
      post "clients/:id/incidents" => "incident_reports#create", as: :create_incident_report

      get "/hotels.csv" => "hotels#index", as: :hotels_csv
      get "/hotels/importer" => "hotels#importer"
      post "/hotels/import" => "hotels#import"
    end
  end
 
  root to: "landing#index"
end
