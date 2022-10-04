FactoryBot.define do
  factory :hotel do
    name { "#{FFaker::Company.name} hotel" }
    active { true }
    address do
      {
        street: FFaker::Address.street_address,
        city: FFaker::Address.city,
        state: FFaker::AddressUS.state,
        zip: FFaker::AddressUS.zip_code
      }
    end
    phone { FFaker::PhoneNumber.phone_number }
  end
end
