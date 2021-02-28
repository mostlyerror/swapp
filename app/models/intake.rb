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

  private 

    def trim_survey_fields
      survey.present? && survey.keys.each do |key|
        survey[key] = survey[key]&.strip
      end
    end
end
