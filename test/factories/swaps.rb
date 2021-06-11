FactoryBot.define do
  factory :swap do
    start_date { Date.current + 1 }
    end_date { Date.current + 3 }
    intake_start_date { self.start_date - 1 }
    intake_end_date { self.end_date - 1 }
    intake_dates { (self.intake_start_date..self.intake_end_date).to_a }

    after(:create) do |swap|
      FactoryBot.create(:availability, swap: swap, vacant: 10)
    end

    trait :past do
      start_date { Date.current - 7 }
      end_date { Date.current - 4 }
      intake_start_date { self.start_date - 1 }
      intake_end_date { self.end_date - 1 }
      intake_dates { (self.intake_start_date..self.intake_end_date).to_a }
    end

    trait :current do
      start_date { Date.current.yesterday }
      end_date { Date.current.tomorrow }
      intake_start_date { self.start_date - 1 }
      intake_end_date { self.end_date - 1 }
      intake_dates { (self.intake_start_date..self.intake_end_date).to_a }
    end

    trait :tomorrow do
      start_date { Date.current + 1 }
      end_date { Date.current + 3 }
      intake_start_date { self.start_date - 1 }
      intake_end_date { self.end_date - 1 }
      intake_dates { (self.intake_start_date..self.intake_end_date).to_a }
    end

    trait :future do
      start_date { Date.current + 6 }
      end_date { Date.current + 8 }
      intake_start_date { self.start_date - 1 }
      intake_end_date { self.end_date - 1 }
      intake_dates { (self.intake_start_date..self.intake_end_date).to_a }
    end
  end
end
