FactoryBot.define do
  factory :swap_period do
    trait :past do
      start_date { Date.current - 7 }
      end_date { Date.current - 4 }
    end

    trait :current do
      start_date { Date.current.yesterday }
      end_date { Date.current.tomorrow }
    end

    trait :future do
      start_date { Date.current + 3 }
      end_date { Date.current + 4 }
    end
  end
end
