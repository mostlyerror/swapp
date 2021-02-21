FactoryBot.define do
  factory :availability do
    motel
    swap
    rooms { 1 }
    date { swap.start_date }
  end
end
