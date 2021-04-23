FactoryBot.define do
  factory :availability do
    hotel
    swap
    vacant { 1 }
    date { self.swap.intake_start_date }
  end
end
