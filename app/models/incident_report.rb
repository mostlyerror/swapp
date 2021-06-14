class IncidentReport < ApplicationRecord
  belongs_to :client
  belongs_to :hotel
  belongs_to :reporter, class_name: 'User'
end
