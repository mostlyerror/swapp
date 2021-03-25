FactoryBot.define do
  factory :availability do
    hotel
    swap
    vacant { 1 }
    date { swap.start_date }
  end
end
