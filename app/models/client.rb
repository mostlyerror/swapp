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
  has_many :flagged_hotels, through: :red_flags, source: :hotel

  # Callbacks
  before_save do
    self.race = self.race.reject {|r| r == "0"}
  end

  def name
    "#{first_name} #{last_name}"
  end

  def prior_guests
    vouchers.flat_map(&:guests).uniq
  end

  def ban_at!(hotel)
    return false if existing_flag = red_flags.find_by(hotel: hotel)
    red_flags.create(hotel: hotel)
  end

  def ban!
    update(banned: true)
  end

  def unban!
    update(banned: false)
  end

  def partial_ban?
    !banned && red_flags.any?
  end

  def no_flags?
    !banned && red_flags.empty?
  end

  def current_voucher
    vouchers.where(swap: Swap.current).last
  end

  def has_received_voucher_this_swap_period?
    !current_voucher.nil?
  end
end
