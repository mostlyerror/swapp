FactoryBot.define do
  factory :voucher do
    client
    user
    motel
    swap
    check_in { self.swap.start_date }
    check_out { self.swap.end_date }
  end
end
