require 'ffaker'

FactoryBot.define do
  factory :hotel do
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
  end
end