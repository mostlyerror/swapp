class Contact < ApplicationRecord
  has_many :hotels_contacts, class_name: "HotelContact", table_name: :hotels_contacts
  has_many :hotels, through: :hotels_contacts
end
