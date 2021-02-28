class Intake < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  belongs_to :user
  before_save :trim_survey_fields

  SLEEP_LAST_NIGHT = OpenStruct.new(
    key: :where_did_you_sleep_last_night,
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
    key: :why_not_shelter,
    text: "What is the reason you have not accessed shelter?",
    choices: [
      "No room",
      "No transportation",
      "Prior background issues",
      "Doesn't accept pets",
      "Safety Concerns",
      "No ID",
      "Banned from shelter",
      "Current restraining order",
      "Other"
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
    key: :armed_forces,
    text: "Have you ever served in the US Armed Forces (Army, Navy, Air Force, Marines or Coast Guard)?", 
    choices: %w[ Yes No ]
  )

  ACTIVE_DUTY = OpenStruct.new(
    key: :active_duty,
    text: "Were you ever called into active duty as a member of the National Guard or as a Reservist?",
    choices: %w[ Yes No ]
  )

  SUBSTANCE_ABUSE = OpenStruct.new(
    key: :substance_abuse,
    text: "Do you have any Substance Abuse Issues?",
    choices: %w[ Yes No ]
  )

  SUBSTANCE_ABUSE_IMPAIRMENT = OpenStruct.new(
    key: :substance_abuse_impairment,
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  CHRONIC_HEALTH_CONDITION = OpenStruct.new(
    key: :chronic_health_condition,
    text: "Do you have a Chronic Health Condition?",
    choices: %w[ Yes No ]
  )

  CHRONIC_HEALTH_CONDITION_IMPAIRMENT = OpenStruct.new(
    key: :chronic_health_condition_impairment,
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_CONDITION = OpenStruct.new(
    key: :mental_health_condition,
    text: "Do you have a Mental Health Condition?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_CONDITION_IMPAIRMENT = OpenStruct.new(
    key: :mental_health_condition_impairment,
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_DISABILITY = OpenStruct.new(
    key: :mental_health_disability,
    text: "Do you have a Mental Health Disability?",
    choices: %w[ Yes No ]
  )

  MENTAL_HEALTH_DISABILITY_IMPAIRMENT = OpenStruct.new(
    key: :mental_health_disability_impairment,
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  PHYSICAL_DISABILITY = OpenStruct.new(
    key: :physical_disability,
    text: "Do you have a Physical Disability?",
    choices: %w[ Yes No ]
  )

  PHYSICAL_DISABILITY_IMPAIRMENT = OpenStruct.new(
    key: :physical_disability_impairment,
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  DEVELOPMENTAL_DISABILITY = OpenStruct.new(
    key: :developmental_disability,
    text: "Do you have a Developmental Disability?",
    choices: %w[ Yes No ]
  )

  DEVELOPMENTAL_DISABILITY_IMPAIRMENT = OpenStruct.new(
    key: :developmental_disability_impairment,
    text: "If yes, is this a long-term disease that impairs your ability to hold a job or live independently?",
    choices: %w[ Yes No ]
  )

  FLEEING_DOMESTIC_VIOLENCE = OpenStruct.new(
    key: :fleeing_domestic_violence,
    text: "Are you experiencing homelessness because you are fleeing Domestic Violence, Sexual Assault or Stalking?",
    choices: %w[ Yes No ]
  )

  private 

    def trim_survey_fields
      survey.present? && survey.keys.each do |key|
        survey[key] = survey[key]&.strip
      end
    end
end
