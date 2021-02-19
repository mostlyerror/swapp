FactoryBot.define do
  factory :voucher do
    client
    user
    motel
    swap_period
    check_in { self.swap_period.start_date }
    check_out { self.swap_period.end_date }
  end
end
