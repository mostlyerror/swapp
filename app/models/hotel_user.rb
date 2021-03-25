class HotelUser < ApplicationRecord
  self.table_name = :hotels_users
  belongs_to :user
  belongs_to :hotel
  # add callbacks to flush & fill on creation
  # destroy all records with the user_id of the newly created record
end
