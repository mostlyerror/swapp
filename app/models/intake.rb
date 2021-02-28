class Intake < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  belongs_to :user
  before_save :trim_survey_fields

  WORKING = [
    "No",
    "Yes - Full-Time",
    "Yes - Part-Time",
    "Yes - Seasonal/Temporary"
  ]

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

  private 

    def trim_survey_fields
      survey.present? && survey.keys.each do |key|
        survey[key] = survey[key]&.strip
      end
    end
end
