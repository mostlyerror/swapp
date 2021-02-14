class Client < ApplicationRecord
  validates_presence_of :first_name, :last_name, :date_of_birth, :gender

  has_many :incident_reports
end
