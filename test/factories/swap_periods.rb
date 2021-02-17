FactoryBot.define do
  factory :swap_period do
    trait :past do
      start_date { 7.days.ago }
      end_date { 4.days.ago }
    end

    trait :current do
      start_date { 1.day.ago }
      end_date { 1.day.from_now }
    end

    trait :future do
      start_date { 3.days.from_now }
      end_date { 4.days.from_now }
    end
  end
end
