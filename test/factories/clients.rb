FactoryBot.define do
  factory :client do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    date_of_birth { Faker::Date.birthday }
    gender { Client::GENDER.sample }
    ethnicity { Client::ETHNICITY.sample }
    email { Faker::Internet.email }
    phone_number_raw { Faker::PhoneNumber.phone_number }

    after :create do |client|
      client.races << Race.order("RANDOM()").first
    end
  end
end
