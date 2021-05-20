FactoryBot.define do
  factory :user do
<<<<<<< HEAD
    email { Faker::Internet.email }
    password = Faker::Internet.password
    password { password }
    password_confirmation { password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
=======
    email { FFaker::Internet.email }
    password = FFaker::Internet.password
    password { password }
    password_confirmation { password }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
    admin_user { false }
    intake_user { true }

    trait :admin_user do
      admin_user { true }
    end
  end
end
