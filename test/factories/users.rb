FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password = FFaker::Internet.password
    password { password }
    password_confirmation { password }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    admin_user { false }
    intake_user { true }

    trait :admin_user do
      admin_user { true }
    end
  end
end
