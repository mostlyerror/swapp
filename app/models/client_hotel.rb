class ClientHotel < ApplicationRecord
    self.table_name = :clients_hotels
    belongs_to :client
    belongs_to :hotel
  end
  