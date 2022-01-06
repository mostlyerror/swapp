# == Schema Information
# Schema version: 20211103053452
#
# Table name: swaps
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  intake_dates :date             default([]), is an Array
#  start_date   :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :swap do
    start_date { Date.current + 1 }
    end_date { Date.current + 3 }
    intake_dates { ((start_date - 1)..(end_date - 1)).to_a }

    after(:create) do |swap|
      FactoryBot.create(:availability, swap: swap, vacant: 10)
    end

    trait :past do
      start_date { Date.current - 7 }
      end_date { Date.current - 4 }
      intake_dates { ((start_date - 1)..(end_date - 1)).to_a }
    end

    trait :current do
      start_date { Date.current.yesterday }
      end_date { Date.current.tomorrow }
      intake_dates { ((start_date - 1)..(end_date - 1)).to_a }
    end

    trait :tomorrow do
      start_date { Date.current + 1 }
      end_date { Date.current + 3 }
      intake_dates { ((start_date - 1)..(end_date - 1)).to_a }
    end

    trait :future do
      start_date { Date.current + 6 }
      end_date { Date.current + 8 }
      intake_dates { ((start_date - 1)..(end_date - 1)).to_a }
    end
  end
end
