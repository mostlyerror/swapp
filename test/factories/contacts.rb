FactoryBot.define do
  factory :contact do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    phone { FFaker::PhoneNumber.phone_number }
    preferred_contact_method { %w[text email phone].sample }
    title { %w[front_desk general_manager].sample }
  end
end
