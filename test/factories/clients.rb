FactoryBot.define do
  factory :client do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday }
    gender { Client::GENDER.sample }
    ethnicity { Client::ETHNICITY.sample }
    email { Faker::Internet.email }
    phone_number { '5555555555' }
    race { [Client::RACE.sample] }

    veteran { false }
    trait :veteran do
      veteran { true }
      veteran_military_branch { Intake::VETERAN_MILITARY_BRANCH.choices.sample }
      veteran_separation_year { Faker::Date.backward(days: rand(10 * 360)).year }
      veteran_discharge_status { Intake::VETERAN_DISCHARGE_STATUS.choices.sample }
    end
  end
end
