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
class User < ApplicationRecord
  has_logidze
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :incident_reports, as: :reporter
  has_many :intakes

  has_many :hotel_users, class_name: "HotelUser", table_name: :hotels_users
  has_many :hotels, through: :hotel_users

  def hotel
    hotels.first
  end

  def name
    "#{first_name} #{last_name}"
  end
end
