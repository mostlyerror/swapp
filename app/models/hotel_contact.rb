# == Schema Information
# Schema version: 20220924214711
#
# Table name: hotels_contacts
#
#  id         :bigint           not null, primary key
#  log_data   :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  contact_id :bigint           indexed, indexed => [hotel_id]
#  hotel_id   :bigint           indexed, indexed => [contact_id]
#
# Indexes
#
#  index_hotels_contacts_on_contact_id               (contact_id)
#  index_hotels_contacts_on_hotel_id                 (hotel_id)
#  index_hotels_contacts_on_hotel_id_and_contact_id  (hotel_id,contact_id) UNIQUE
#
class HotelContact < ApplicationRecord
  self.table_name = :hotels_contacts
  belongs_to :hotel
  belongs_to :contact
end
