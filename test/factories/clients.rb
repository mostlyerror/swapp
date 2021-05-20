FactoryBot.define do
  factory :client do
<<<<<<< HEAD
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday }
    gender { Client::GENDER.sample }
    ethnicity { Client::ETHNICITY.sample }
    email { Faker::Internet.email }
    phone_number { '5555555555' }
    race { [Client::RACE.sample] }

=======
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    date_of_birth { FFaker::Time.date } 
    gender { Client::GENDER.sample }
    ethnicity { Client::ETHNICITY.sample }
    email { FFaker::Internet.email }
    phone_number { '5555555555' }
    race { [Client::RACE.sample] }
    family_members { {} }
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
    veteran { false }
    trait :veteran do
      veteran { true }
      veteran_military_branch { Intake::VETERAN_MILITARY_BRANCH.choices.sample }
<<<<<<< HEAD
      veteran_separation_year { Faker::Date.backward(days: rand(10 * 360)).year }
      veteran_discharge_status { Intake::VETERAN_DISCHARGE_STATUS.choices.sample }
    end
  end
end
=======
      veteran_separation_year { FFaker::Time.between(360.days.ago, 10.days.ago).year }
      veteran_discharge_status { Intake::VETERAN_DISCHARGE_STATUS.choices.sample }
    end
  end
end
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
