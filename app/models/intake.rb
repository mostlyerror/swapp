# == Schema Information
# Schema version: 20211223223312
#
# Table name: intakes
#
#  id                                              :bigint           not null, primary key
#  active_duty                                     :boolean
#  are_you_working                                 :string
#  armed_forces                                    :boolean
#  chronic_health_condition                        :boolean
#  developmental_disability                        :boolean
#  episodes_last_three_years_fewer_than_four_times :boolean
#  fleeing_domestic_violence                       :boolean
#  have_you_ever_experienced_homelessness_before   :boolean
#  health_insurance                                :string
#  homelessness_date_began                         :date
#  homelessness_episodes_last_three_years          :string
#  homelessness_first_time                         :boolean
#  homelessness_how_long_this_time                 :string
#  homelessness_total_last_three_years             :string
#  household_tanf                                  :boolean
#  income_source_alimony                           :integer
#  income_source_any                               :boolean
#  income_source_child_support                     :integer
#  income_source_earned_income                     :integer
#  income_source_general_assistance                :integer
#  income_source_retirement                        :integer
#  income_source_ssdi                              :integer
#  income_source_ssi                               :integer
#  income_source_tanf                              :integer
#  income_source_unemployment_insurance            :integer
#  income_source_veteran_service_compensation      :integer
#  last_permanent_residence_county                 :string
#  mental_health_condition                         :boolean
#  mental_health_disability                        :boolean
#  non_cash_benefits                               :jsonb
#  physical_disability                             :boolean
#  substance_abuse                                 :boolean
#  substance_misuse                                :string
#  total_how_long_shelters_or_streets              :string
#  created_at                                      :datetime         not null
#  updated_at                                      :datetime         not null
#  client_id                                       :bigint           not null, indexed
#  swap_id                                         :bigint           indexed
#  user_id                                         :bigint           not null, indexed
#
# Indexes
#
#  index_intakes_on_client_id  (client_id)
#  index_intakes_on_swap_id    (swap_id)
#  index_intakes_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_3c0b295085  (client_id => clients.id)
#  fk_rails_5601279132  (user_id => users.id)
#  fk_rails_cc14202886  (swap_id => swaps.id)
#
class Intake < ApplicationRecord
  has_logidze
  belongs_to :swap, optional: true
  belongs_to :client
  accepts_nested_attributes_for :client
  belongs_to :user

  auto_strip_attributes :homelessness_first_time,
      :household_tanf,
      :homelessness_episodes_last_three_years,
      :armed_forces,
      :active_duty,
      :substance_misuse,
      :chronic_health_condition,
      :mental_health_disability,
      :physical_disability,
      :developmental_disability,
      :fleeing_domestic_violence,
      :homelessness_how_long_this_time,
      :homelessness_total_last_three_years,
      :are_you_working,
      :last_permanent_residence_county,
      :health_insurance,
      :income_source_earned_income,
      :income_source_ssdi,
      :income_source_ssi,
      :income_source_unemployment_insurance,
      :income_source_tanf,
      :income_source_child_support,
      :income_source_retirement,
      :income_source_alimony,
      :income_source_veteran_service_compensation,
      :income_source_general_assistance
      :non_cash_benefits

  FIRST_NAME = OpenStruct.new(
    key: :first_name,
    text: "First Name" 
  )

  LAST_NAME = OpenStruct.new(
    key: :last_name,
    text: "Last Name"
  )

  DATE_OF_BIRTH = OpenStruct.new(
    key: :date_of_birth,
    text: "Date of Birth"
  )

  GENDER = OpenStruct.new(
    key: :gender,
    text: "Gender Identity",
    choices: Client::GENDER
  )

  RACE = OpenStruct.new(
    key: :race,
    text: "Race",
    choices: Client::RACE
  )

  ETHNICITY = OpenStruct.new(
    key: :ethnicity,
    text: "Hispanic or Latino?",
    choices: Client::ETHNICITY
  )

  HOMELESSNESS_FIRST_TIME = OpenStruct.new(
    key: :homelessness_first_time,
    text: "Is this the first time you have been homeless?", 
    choices: %w[ Yes No ]
  )

  HOUSEHOLD_TANF = OpenStruct.new(
    key: :household_tanf,
    text: "Does anyone in your household receive TANF benefits?", 
    choices: %w[ Yes No ]
  )

  HOMELESSNESS_DATE_BEGAN = OpenStruct.new(
    key: :homelessness_date_began,
    text: "Approximate date homelessness first began"
  )

  HOMELESSNESS_HOW_LONG_THIS_TIME = OpenStruct.new(
    key: :homelessness_how_long_this_time,
    text: "How long have you been homeless this time?", 
    choices: [
      "1 night or less",
      "2 to 6 nights",
      "1 week or more but less than 1 month",
      "1 month or more but less than 90 days",
      "90 days or more but less than 1 year",
      "more than 1 year"
    ]
  )

  HOMELESSNESS_EPISODES_LAST_THREE_YEARS = OpenStruct.new(
    key: :homelessness_episodes_last_three_years,
    text: "Number of episodes of homelessness in the past three years?", 
    choices: [
      '1',
      '2',
      '3',
      '4 or more'
    ]
  )

  HOMELESSNESS_TOTAL_LAST_THREE_YEARS = OpenStruct.new(
    key: :homelessness_total_last_three_years,
    text: "Total number of months of homelessness in the past three years.", 
    choices: [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      'More than 12'
    ]
  )

  SLEEP_LAST_NIGHT = OpenStruct.new(
    key: :where_did_you_sleep_last_night,
    text: "Where did you sleep last night?",
    choices: [
      "In own home",
      "In a shelter",
      "In a hotel",
      "Doubled Up",
      "In a car",
      "In an RV",
      "On the streets or in a tent",
      "In the hospital",
      "Incarcerated",
      "Institution",
    ]
  )

  CITY_LAST_NIGHT = OpenStruct.new(
    key: :what_city_did_you_sleep_in_last_night,
    text: "What city did you sleep in last night?"
  )

  WHY_NOT_SHELTER = OpenStruct.new(
    key: :why_not_shelter,
    text: "Why haven't you accessed shelter?",
    choices: [
      "No room",
      "No transportation",
      "Prior background issues",
      "Doesn't accept pets",
      "Safety concerns",
      "No ID",
      "Banned from shelter",
      "Current restraining order",
      "Did not want to separate from significant other",
    ]
  )
  
  HEALTH_INSURANCE = OpenStruct.new(
    key: :health_insurance,
    text: "Are you covered by health insurance?",
    choices: [
      "No",
      "Medicaid",
      "Medicare",
      "VA Medical",
      "Employer Provided",
      "Private Pay",
      "State Children's Health Insurance Program",
      "State Health Insurance for Adults",
      "Health Insurance through Cobra",
      "Indian Health Services Program"
    ]
  )

  INCOME_SOURCE = OpenStruct.new(
    key: :income_source_any,
    text: "Do you have income of any source?",
    choices: %w[ Yes No ],
    sub_choices: {
      income_source_earned_income: "Earned Income (Paycheck)",
      income_source_ssdi: "SSDI (Disability)",
      income_source_ssi: "SSI",
      income_source_unemployment_insurance: "Unemployment Insurance",
      income_source_tanf: "TANF",
      income_source_child_support: "Child Support",
      income_source_retirement: "Retirement from Former Job",
      income_source_alimony: "Alimony or Spousal Support",
      income_source_veteran_service_compensation: "VA Service Compensation",
      income_source_general_assistance: "General Assistance"
    }
  )


  ARE_YOU_WORKING = OpenStruct.new(
    key: :are_you_working,
    text: "Are you working?",
    choices: [
      "No",
      "Yes - Full-Time",
      "Yes - Part-Time",
      "Yes - Seasonal/Temporary"
    ]
  )

  NON_CASH_BENEFITS = OpenStruct.new(
    key: :non_cash_benefits,
    text: "Are you receiving non-cash benefits?",
    choices: [
      "No",
      "SNAP (Food Stamps)",
      "WIC",
      "TANF Childcare Services",
      "TANF Transportation Services"
    ]
  )

  VETERAN = OpenStruct.new(
    key: :veteran,
    text: "Are you a veteran?",
    choices: %w[ Yes No ]
  )

  VETERAN_MILITARY_BRANCH = OpenStruct.new(
    key: :veteran_military_branch,
    text: "Branch of military",
    choices: [
      "Army",
      "Navy",
      "Airforce",
      "Marines",
      "Coast Guard"
    ],
  )

  VETERAN_SEPARATION_YEAR = OpenStruct.new(
    key: :veteran_separation_year,
    text: "Year separated"
  )

  VETERAN_DISCHARGE_STATUS = OpenStruct.new(
    key: :veteran_discharge_status,
    text: "Discharge status",
    choices: [
      "Honorable",
      "Dishonorable",
      "Bad Conduct",
      "Other than honorable",
    ]
  )

  ACTIVE_DUTY = OpenStruct.new(
    key: :active_duty,
    text: "Were you ever called into active duty as a member of the National Guard or as a Reservist?",
    choices: %w[ Yes No ]
  )

  SUBSTANCE_MISUSE = OpenStruct.new(
    key: :substance_misuse,
    text: "Do you have any Substance Misuse Issues?",
    choices: [ 
      "No",
      "Alcohol",
      "Drugs",
      "Alcohol and Drugs"
     ]
  )

  CHRONIC_HEALTH_CONDITION = OpenStruct.new(
    key: :chronic_health_condition,
    text: "Do you have a Chronic Health Condition?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_DISABILITY = OpenStruct.new(
    key: :mental_health_disability,
    text: "Do you have a Mental Health Disability?",
    choices: %w[ Yes No ]
  )

  PHYSICAL_DISABILITY = OpenStruct.new(
    key: :physical_disability,
    text: "Do you have a Physical Disability?",
    choices: %w[ Yes No ]
  )

  DEVELOPMENTAL_DISABILITY = OpenStruct.new(
    key: :developmental_disability,
    text: "Do you have a Developmental Disability?",
    choices: %w[ Yes No ]
  )

  FLEEING_DOMESTIC_VIOLENCE = OpenStruct.new(
    key: :fleeing_domestic_violence,
    text: "Are you fleeing Domestic Violence, Sexual Assault or Stalking?",
    choices: %w[ Yes No ]
  )

  NUM_ADULTS_HOUSEHOLD = OpenStruct.new(
    key: :num_adults_in_household,
    text: "Number of adults in household",
    placeholder: "enter numeric value"
  )

  NUM_CHILDREN_HOUSEHOLD = OpenStruct.new(
    key: :num_children_in_household,
    text: "Number of children  in household under 18 years old",
    placeholder: "enter numeric value"
  )

  LAST_PERMANENT_RESIDENCE_COUNTY= OpenStruct.new(
    key: :last_permanent_residence_county,
    text: "In what county was your last permanent residence?",
    placeholder: "Adams"
  )

  CHECK_IN = OpenStruct.new(
    key: :check_in,
    text: "Check In"
  )

  CHECK_OUT = OpenStruct.new(
    key: :check_out,
    text: "Check Out"
  )

  HOTEL_ID = OpenStruct.new(
    key: :hotel_id,
    text: "Hotel (vouchers remaining)", 
  )

  PHONE_NUMBER = OpenStruct.new(
    key: :phone_number,
    text: "Phone Number (optional)"
  )

  EMAIL= OpenStruct.new(
    key: :email,
    text: "Email (optional)"
  )

  BUS_PASS = OpenStruct.new(
    key: :bus_pass,
    text: "Bus Pass?",
    choices: %w[ Yes No ]
  )

  KING_SOOPERS_CARD = OpenStruct.new(
    key: :king_soopers_card,
    text: "King Soopers Card?",
    choices: %w[ Yes No ]
  )

  RELATIONSHIP = OpenStruct.new(
    key: :relationship,
    text: "Relationship"
  )

  # currently this is used in the family member intake form only
  DISABLING_CONDITION = OpenStruct.new(
    key: :disabling_condition,
    text: "Disabling Condition?",
    choices: %w[ Yes No ]
  )

  GUESTS = OpenStruct.new(
    key: :guests,
    text: "Are you bringing guests?",
    choices: %w[ Yes No ]
  )
end
