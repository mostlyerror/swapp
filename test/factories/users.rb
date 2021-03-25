FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password = Faker::Internet.password
    password { password }
    password_confirmation { password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    admin_user { false }

    trait :admin_user do
      admin_user { true }
    end
  end
end
