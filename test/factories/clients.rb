# == Schema Information
# Schema version: 20211103053452
#
# Table name: clients
#
#  id                       :bigint           not null, primary key
#  banned                   :boolean          default(FALSE)
#  date_of_birth            :date
#  email                    :string
#  ethnicity                :string
#  family_members           :jsonb
#  first_name               :string           not null
#  force_intake             :boolean          default(FALSE)
#  gender                   :string
#  last_name                :string           not null
#  phone_number             :string
#  race                     :jsonb
#  veteran                  :boolean
#  veteran_discharge_status :string
#  veteran_military_branch  :string
#  veteran_separation_year  :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#
FactoryBot.define do
  factory :client do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    date_of_birth { FFaker::Time.date }
    gender { Client::GENDER.sample }
    ethnicity { Client::ETHNICITY.sample }
    email { FFaker::Internet.email }
    phone_number { "5555555555" }
    race { [Client::RACE.sample] }
    family_members { {} }
    veteran { false }
    trait :veteran do
      veteran { true }
      veteran_military_branch { Intake::VETERAN_MILITARY_BRANCH.choices.sample }
      veteran_separation_year { FFaker::Time.between(360.days.ago, 10.days.ago).year }
      veteran_discharge_status { Intake::VETERAN_DISCHARGE_STATUS.choices.sample }
    end
  end
end
