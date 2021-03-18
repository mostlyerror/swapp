class Intake < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  belongs_to :user

  auto_strip_attributes :homelessness_first_time,
      :episodes_last_three_years_fewer_than_four_times,
      :armed_forces,
      :active_duty,
      :substance_misuse,
      :chronic_health_condition,
      :mental_health_condition,
      :mental_health_disability,
      :physical_disability,
      :developmental_disability,
      :fleeing_domestic_violence,
      :how_long_this_time,
      :homelessness_total_last_three_years,
      :are_you_working,
      :last_permanent_residence_county
      :health_insurance

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

  HOMELESSNESS_HOW_LONG_THIS_TIME = OpenStruct.new(
    key: :homelessness_how_long_this_time,
    text: "How long have you been homeless this time?", 
    placeholder: "(e.g, 2 months, 5 years, etc.)"
  )

  HOMELESSNESS_EPISODES_LAST_THREE_YEARS = OpenStruct.new(
    key: :episodes_last_three_years_fewer_than_four_times,
    text: "Including this time, how many separate times have you stayed in shelters or on the streets in the past 3 years?", 
    choices: [
      "Fewer than 4 times",
      "4 or more times"
    ]
  )

  HOMELESSNESS_TOTAL_LAST_THREE_YEARS = OpenStruct.new(
    key: :homelessness_total_last_three_years,
    text: "Total number of months of homelessness in the past three years.", 
    choices: [
      "One", 
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Eleven",
      "Twelve",
      "More than Twelve"
    ]
  )

  SLEEP_LAST_NIGHT = OpenStruct.new(
    key: :where_did_you_sleep_last_night,
    text: "Where did you sleep last night?",
    choices: [
      "In own home",
      "In a shelter",
      "In a motel",
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

  MENTAL_HEALTH_CONDITION = OpenStruct.new(
    key: :mental_health_condition,
    text: "Do you have a Mental Health Condition?",
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
    text: "Are you experiencing homelessness because you are fleeing Domestic Violence, Sexual Assault or Stalking?",
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

  KING_SOOPERS_CARD = OpenStruct.new(
    key: :king_soopers_card,
    text: "King Soopers Card?",
    choices: %w[ Yes No ]
  )

  BUS_PASS = OpenStruct.new(
    key: :bus_pass,
    text: "Bus Pass?",
    choices: %w[ Yes No ]
  )

  CHECK_IN = OpenStruct.new(
    key: :check_in,
    text: "Check In"
  )

  CHECK_OUT = OpenStruct.new(
    key: :check_out,
    text: "Check Out"
  )

  MOTEL_ID = OpenStruct.new(
    key: :motel_id,
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
end
