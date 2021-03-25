class Hotel < ApplicationRecord
  has_many :availabilities
  has_many :vouchers
  has_many :hotel_users, class_name: 'HotelUser', table_name: :hotels_users
  has_many :users, through: :hotel_users

  validates_presence_of :name

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end
end
