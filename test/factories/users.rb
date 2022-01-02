# == Schema Information
# Schema version: 20211223223312
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  active                 :boolean          default(TRUE)
#  admin_user             :boolean          default(FALSE), not null
#  email                  :string           default(""), not null, indexed
#  encrypted_password     :string           default(""), not null
#  first_name             :string           default(""), not null
#  hotel_user             :boolean          default(FALSE), not null
#  intake_user            :boolean          default(FALSE), not null
#  last_name              :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string           indexed
#  show_swap_panel        :boolean          default(TRUE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    active { true }
    email { FFaker::Internet.email }
    password = FFaker::Internet.password
    password { password }
    password_confirmation { password }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    admin_user { false }
    intake_user { true }

    trait :admin_user do
      admin_user { true }
    end
  end
end
