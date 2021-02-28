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
    question: "Where did you sleep last night?",
    answers: [
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

  private 

    def trim_survey_fields
      survey.present? && survey.keys.each do |key|
        survey[key] = survey[key]&.strip
      end
    end
end
