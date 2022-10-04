FactoryBot.define do
  factory :availability do
    hotel
    swap
    vacant { 1 }
    date { swap.intake_dates.first }
  end
end
