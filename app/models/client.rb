class Client < ApplicationRecord
  validates_presence_of :first_name, :last_name, :date_of_birth, :gender
  has_many :intakes
  has_many :vouchers
  has_many :incident_reports

  GENDER = [
    "Female",
    "Male",
    "Trans Female (MTF)",
    "Trans Male (FTM)",
    "Gender Non-conforming",
    "Client Doesn't Know",
    "Client Refused",
  ]

  RACE = [
    "American Indian or Alaskan Native",
    "Asian",
    "Black or African American",
    "Native Hawaiian or Other Pacific Islander",
    "White",
  ]

  ETHNICITY = [
    "Hispanic or Latino",
    "Not Hispanic or Latino",
  ]

  def name
    "#{first_name} #{last_name}"
  end
end
