class Intake < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  belongs_to :user
  before_save :trim_survey_fields

  FIRST_NAME = OpenStruct.new(
    key: 'first_name',
    text: "First Name" 
  )

  LAST_NAME = OpenStruct.new(
    key: 'last_name',
    text: "Last Name"
  )

  DATE_OF_BIRTH = OpenStruct.new(
    key: 'date_of_birth',
    text: "Date of Birth"
  )

  GENDER = OpenStruct.new(
    key: 'gender',
    text: "Gender Identity",
    choices: Client::GENDER
  )

  RACE = OpenStruct.new(
    key: 'race',
    text: "Race",
    choices: Client::RACE
  )

  ETHNICITY = OpenStruct.new(
    key: 'ethnicity',
    text: "Hispanic or Latino?",
    choices: Client::ETHNICITY
  )

  HOMELESSNESS_FIRST_TIME = OpenStruct.new(
    key: 'homelessness_first_time',
    text: "Is this the first time you have been homeless?", 
    choices: %w[ Yes No ]
  )

  HOMELESSNESS_HOW_LONG_THIS_TIME = OpenStruct.new(
    key: 'homelessness_how_long_this_time',
    text: "How long have you been homeless this time?", 
    placeholder: "(e.g, 2 months, 5 years, etc.)"
  )

  HOMELESSNESS_EPISODES_LAST_THREE_YEARS = OpenStruct.new(
    key: 'homelessness_episodes_last_three_years',
    text: "Including this time, how many separate times have you stayed in shelters or on the streets in the past 3 years?", 
    choices: [
      "Fewer than 4 times",
      "4 or more times"
    ]
  )

  HOMELESSNESS_EPISODES_HOW_LONG = OpenStruct.new(
    key: 'homelessness_episodes_how_long',
    text: "In total, how long did you stay in shelters or on the streets those times?", 
    placeholder: "(e.g, 2 months, 5 years, etc.)"
  )

  SLEEP_LAST_NIGHT = OpenStruct.new(
    key: 'where_did_you_sleep_last_night',
    text: "Where did you sleep last night?",
    choices: [
      "In own home",
      "In a shelter",
      "In a motel",
      "Doubled Up",
      "In a car/RV",
      "On the streets or in a tent",
      "In the hospital",
      "Incarcerated",
    ]
  )
  WHY_NOT_SHELTER = OpenStruct.new(
    key: 'why_not_shelter',
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

  ARE_YOU_WORKING = OpenStruct.new(
    key: 'are_you_working',
    text: "Are you working?",
    choices: [
      "No",
      "Yes - Full-Time",
      "Yes - Part-Time",
      "Yes - Seasonal/Temporary"
    ]
  )

  VETERAN = OpenStruct.new(
    key: 'armed_forces',
    text: "Have you ever served in the US Armed Forces (Army, Navy, Air Force, Marines or Coast Guard)?", 
    choices: %w[ Yes No ]
  )

  ACTIVE_DUTY = OpenStruct.new(
    key: 'active_duty',
    text: "Were you ever called into active duty as a member of the National Guard or as a Reservist?",
    choices: %w[ Yes No ]
  )

  SUBSTANCE_ABUSE = OpenStruct.new(
    key: 'substance_abuse',
    text: "Do you have any Substance Abuse Issues?",
    choices: %w[ Yes No ]
  )

  SUBSTANCE_ABUSE_IMPAIRMENT = OpenStruct.new(
    key: 'substance_abuse_impairment',
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  CHRONIC_HEALTH_CONDITION = OpenStruct.new(
    key: 'chronic_health_condition',
    text: "Do you have a Chronic Health Condition?",
    choices: %w[ Yes No ]
  )

  CHRONIC_HEALTH_CONDITION_IMPAIRMENT = OpenStruct.new(
    key: 'chronic_health_condition_impairment',
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_CONDITION = OpenStruct.new(
    key: 'mental_health_condition',
    text: "Do you have a Mental Health Condition?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_CONDITION_IMPAIRMENT = OpenStruct.new(
    key: 'mental_health_condition_impairment',
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_DISABILITY = OpenStruct.new(
    key: 'mental_health_disability',
    text: "Do you have a Mental Health Disability?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_DISABILITY_IMPAIRMENT = OpenStruct.new(
    key: 'mental_health_disability_impairment',
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  PHYSICAL_DISABILITY = OpenStruct.new(
    key: 'physical_disability',
    text: "Do you have a Physical Disability?",
    choices: %w[ Yes No ]
  )

  PHYSICAL_DISABILITY_IMPAIRMENT = OpenStruct.new(
    key: 'physical_disability_impairment',
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  DEVELOPMENTAL_DISABILITY = OpenStruct.new(
    key: 'developmental_disability',
    text: "Do you have a Developmental Disability?",
    choices: %w[ Yes No ]
  )

  DEVELOPMENTAL_DISABILITY_IMPAIRMENT = OpenStruct.new(
    key: 'developmental_disability_impairment',
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  FLEEING_DOMESTIC_VIOLENCE = OpenStruct.new(
    key: 'fleeing_domestic_violence',
    text: "Are you experiencing homelessness because you are fleeing Domestic Violence, Sexual Assault or Stalking?",
    choices: %w[ Yes No ]
  )

  NUM_ADULTS_HOUSEHOLD = OpenStruct.new(
    key: 'num_adults_household',
    text: "Number of adults in household",
    placeholder: "enter numeric value"
  )

  NUM_CHILDREN_HOUSEHOLD = OpenStruct.new(
    key: 'num_children_household',
    text: "Number of children in household",
    placeholder: "enter numeric value"
  )

  LAST_PERMANENT_RESIDENCE_COUNTY= OpenStruct.new(
    key: 'last_permanent_residence_county',
    text: "County of Last Permanent Residence",
    placeholder: "Adams"
  )

  KING_SOOPERS_CARD = OpenStruct.new(
    key: 'king_soopers_card',
    text: "King Soopers Card?",
    choices: %w[ Yes No ]
  )

  BUS_PASS = OpenStruct.new(
    key: 'bus_pass',
    text: "Bus Pass?",
    choices: %w[ Yes No ]
  )

  CHECK_IN = OpenStruct.new(
    key: 'check_in',
    text: "Check In"
  )

  CHECK_OUT = OpenStruct.new(
    key: 'check_out',
    text: "Check Out"
  )

  MOTEL_ID = OpenStruct.new(
    key: 'motel_id',
    text: "Hotel (vouchers remaining)", 
  )

  PHONE_NUMBER = OpenStruct.new(
    key: 'phone_number',
    text: "Phone Number (optional)"
  )

  EMAIL= OpenStruct.new(
    key: 'email',
    text: "Email (optional)"
  )

  private 

    def trim_survey_fields
      survey.present? && survey.keys.each do |key|
        if survey[key].is_a? String
          survey[key] = survey[key]&.strip
        end
      end
    end
end
