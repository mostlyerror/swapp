FactoryBot.define do
  factory :voucher do
    client
    user
    hotel
    swap { Swap.current || create(:swap, :tomorrow) }
    check_in { self.swap.start_date }
    check_out { self.swap.end_date }

    after(:create) do |voucher|
      create(:intake, client: voucher.client, user: voucher.user)
      create(:short_intake, client: voucher.client, user: voucher.user)
    end
  end
end
