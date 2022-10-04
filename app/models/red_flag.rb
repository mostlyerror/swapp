class RedFlag < ApplicationRecord
  self.table_name = :red_flags
  belongs_to :client
  belongs_to :hotel
end
