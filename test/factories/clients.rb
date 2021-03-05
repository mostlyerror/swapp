FactoryBot.define do
  factory :client do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday }
    gender { Client::GENDER.sample }
    ethnicity { Client::ETHNICITY.sample }
    email { Faker::Internet.email }
    phone_number { '5555555555' }
    race { Client::RACE.sample }
  end
end
