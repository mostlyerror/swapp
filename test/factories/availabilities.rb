FactoryBot.define do
  factory :availability do
    motel
    swap
    vacant { 1 }
    date { swap.start_date }
  end
end
