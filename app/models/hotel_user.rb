# == Schema Information
# Schema version: 20220924214711
#
# Table name: hotels_users
#
#  id       :bigint           not null, primary key
#  hotel_id :bigint           not null, indexed
#  user_id  :bigint           not null, indexed
#
# Indexes
#
#  index_hotels_users_on_hotel_id  (hotel_id)
#  index_hotels_users_on_user_id   (user_id)
#
class HotelUser < ApplicationRecord
  self.table_name = :hotels_users
  belongs_to :user
  belongs_to :hotel
  # add callbacks to flush & fill on creation
  # destroy all records with the user_id of the newly created record
end
