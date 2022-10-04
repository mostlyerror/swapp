class HotelContact < ApplicationRecord
  self.table_name = :hotels_contacts
  belongs_to :hotel
  belongs_to :contact
end
