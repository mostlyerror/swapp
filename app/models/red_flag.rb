# == Schema Information
# Schema version: 20211103053452
#
# Table name: red_flags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  client_id  :bigint           indexed
#  hotel_id   :bigint           indexed
#
# Indexes
#
#  index_red_flags_on_client_id  (client_id)
#  index_red_flags_on_hotel_id   (hotel_id)
#
# Foreign Keys
#
#  fk_rails_47fd5348d4  (hotel_id => hotels.id)
#  fk_rails_974f96e3bd  (client_id => clients.id)
#
class RedFlag < ApplicationRecord
  has_logidze
    self.table_name = :red_flags
    belongs_to :client
    belongs_to :hotel
  end
  
