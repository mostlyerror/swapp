require 'ffaker'

FactoryBot.define do
  factory :client do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    date_of_birth { FFaker::Time.date } 
    gender { Client::GENDER.sample }
    ethnicity { Client::ETHNICITY.sample }
    email { FFaker::Internet.email }
    phone_number { '5555555555' }
    race { [Client::RACE.sample] }

    veteran { false }
    trait :veteran do
      veteran { true }
      veteran_military_branch { Intake::VETERAN_MILITARY_BRANCH.choices.sample }
      veteran_separation_year { FFaker::Time.between(360.days.ago, 10.days.ago).year }
      veteran_discharge_status { Intake::VETERAN_DISCHARGE_STATUS.choices.sample }
    end
  end
end