class Client < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :that_sounds_like, against: [:first_name, :last_name], using: :dmetaphone

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
    "American Indian or Alaska Native",
    "Asian",
    "Black or African American",
    "Native Hawaiian or other Pacific Islander",
    "White",
  ]

  ETHNICITY = [
    "Not Hispanic or Latino",
    "Hispanic or Latino",
  ]

  auto_strip_attributes :first_name, :last_name, :race, :phone_number, :email

  validates_presence_of :first_name, :last_name, :date_of_birth
  validates :gender, inclusion: { in: Client::GENDER, allow_nil: true }
  validates :ethnicity, inclusion: { in: Client::ETHNICITY, allow_nil: true }
  # validate :accepted_race_values
  # validates :phone_number, phone: { possible: true, allow_nil: true }
  # validates_format_of :email, with: Devise.email_regexp, allow_nil: true

  has_many :intakes
  has_many :short_intakes
  has_many :vouchers
  has_many :incident_reports

  has_many :red_flags, class_name: 'RedFlag', table_name: :red_flags
<<<<<<< HEAD
  has_many :hotels, through: :red_flags
=======
  has_many :flagged_hotels, through: :red_flags, source: :hotel
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e

  def name
    "#{first_name} #{last_name}"
  end
<<<<<<< HEAD
=======

  def prior_guests
    vouchers.flat_map(&:guests).uniq
  end

  def partial_ban?
    !banned && flagged_hotels.any?
  end

  def no_flags?
    !banned && flagged_hotels.empty?
  end

  def current_voucher
    vouchers.where(swap: Swap.current).last
  end

  def has_received_voucher_this_swap_period?
    !current_voucher.nil?
  end
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
end
