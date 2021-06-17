class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :incident_reports, as: :reporter
  has_many :intakes

  has_many :hotel_users, class_name: 'HotelUser', table_name: :hotels_users
  has_many :hotels, through: :hotel_users

  def hotel
    hotels.first
  end

  def name
    "#{first_name} #{last_name}"
  end
end
