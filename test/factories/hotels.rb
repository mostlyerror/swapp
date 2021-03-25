FactoryBot.define do
  factory :hotel do
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
  end
end