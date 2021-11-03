# == Schema Information
# Schema version: 20211103053452
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  address      :json
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Hotel < ApplicationRecord
  has_many :availabilities
  has_many :vouchers
  has_many :hotel_users, class_name: 'HotelUser', table_name: :hotels_users
  has_many :users, through: :hotel_users
  has_many :hotels_contacts, class_name: "HotelContact", table_name: :hotels_contacts
  has_many :contacts, through: :hotels_contacts
  has_many :red_flags, class_name: 'RedFlag', table_name: :red_flags
  has_many :clients, through: :red_flags

  validates_presence_of :name

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end
end
