FactoryBot.define do
  factory :voucher do
    client
    user
    hotel
    swap { Swap.current || create(:swap, :tomorrow) }
    check_in { self.swap.start_date }
    check_out { self.swap.end_date }
    notes {
      [true, false].sample && Faker::Quote.most_interesting_man_in_the_world || nil
    }

    after(:create) do |voucher|
      create(:intake, client: voucher.client, user: voucher.user)
      create(:short_intake, client: voucher.client, user: voucher.user)
    end
  end
end
