FactoryBot.define do
  factory :hotel do
<<<<<<< HEAD
    name { "#{Faker::Company.name} hotel" }
    address {
      {
        street: Faker::Address.street_address,
        city: Faker::Address.city,
        state: Faker::Address.state,
        zip: Faker::Address.zip
      }
    }
    phone { Faker::PhoneNumber.phone_number }
=======
    name { "#{FFaker::Company.name} hotel" }
    address {
      {
        street: FFaker::Address.street_address,
        city: FFaker::Address.city,
        state: FFaker::AddressUS.state,
        zip: FFaker::AddressUS.zip_code
      }
    }
    phone { FFaker::PhoneNumber.phone_number }
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
  end
end