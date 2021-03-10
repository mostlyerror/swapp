FactoryBot.define do
  factory :swap do
    trait :past do
      start_date { Date.current - 7 }
      end_date { Date.current - 4 }
    end

    trait :current do
      start_date { Date.current.yesterday }
      end_date { Date.current.tomorrow }
    end

    trait :tomorrow do
      start_date { Date.current + 1 }
      end_date { Date.current + 3 }
    end

    trait :future do
      start_date { Date.current + 6 }
      end_date { Date.current + 8 }
    end
  end
end
