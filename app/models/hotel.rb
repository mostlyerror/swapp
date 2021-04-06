class Hotel < ApplicationRecord
  has_many :availabilities
  has_many :vouchers
  has_many :hotel_users, class_name: 'HotelUser', table_name: :hotels_users
  has_many :users, through: :hotel_users

  has_many :clients_hotels, class_name: 'ClientHotel', table_name: :clients_hotels
  has_many :clients, through: :client_hotels

  validates_presence_of :name

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end
end
