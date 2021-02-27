class Client < ApplicationRecord
  ETHNICITY = [
    "Hispanic or Latino",
    "Not Hispanic or Latino",
  ]

  RACE = [
    "American Indian or Alaskan Native",
    "Asian",
    "Black or African American",
    "Native Hawaiian or Other Pacific Islander",
    "White",
  ]

  GENDER = [
    "Female",
    "Male",
    "Trans Female (MTF)",
    "Trans Male (FTM)",
    "Gender Non-Conforming",
    "Client Doesn't Know",
    "Client Refused",
  ]

  validates_presence_of :first_name, :last_name, :date_of_birth 
  validates :phone_number, phone: { possible: true, allow_blank: true }
  validates :gender, inclusion: { in: Client::GENDER, allow_nil: true }

  has_many :intakes
  has_many :vouchers
  has_many :incident_reports

  def name
    "#{first_name} #{last_name}"
  end
end
