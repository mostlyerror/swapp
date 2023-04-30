class Contact < ApplicationRecord
  has_many :hotels_contacts, class_name: "HotelContact"
  has_many :hotels, through: :hotels_contacts
end
