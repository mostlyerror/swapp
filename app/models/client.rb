class Client < ApplicationRecord
  GENDER = [
    "Female",
    "Male",
    "Trans Female (MTF)",
    "Trans Male (FTM)",
    "Gender Non-Conforming",
    "Client Doesn't Know",
    "Client Refused",
  ]

  RACE = [
    "American Indian or Alaskan Native",
    "Asian",
    "Black or African American",
    "Native Hawaiian or other Pacific Islander",
    "White",
  ]

  ETHNICITY = [
    "Hispanic or Latino",
    "Not Hispanic or Latino",
  ]

  validates_presence_of :first_name, :last_name, :date_of_birth 
  validates :gender, inclusion: { in: Client::GENDER, allow_nil: true }
  validates :ethnicity, inclusion: { in: Client::ETHNICITY, allow_nil: true }
  auto_strip_attributes :race
  # validate :accepted_race_values
  auto_strip_attributes :phone_number
  validates :phone_number, phone: { possible: true, allow_nil: true }
  auto_strip_attributes :email 
  validates_format_of :email, with: Devise.email_regexp, allow_nil: true

  has_many :intakes
  has_many :vouchers
  has_many :incident_reports

  def name
    "#{first_name} #{last_name}"
  end
end
