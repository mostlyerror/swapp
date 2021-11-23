# == Schema Information
# Schema version: 20211123040336
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  address      :jsonb
#  deleted_at   :datetime
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
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
