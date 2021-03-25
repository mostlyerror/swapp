FactoryBot.define do
  factory :intake do
    homelessness_first_time { [true, false].sample }
  end
end
