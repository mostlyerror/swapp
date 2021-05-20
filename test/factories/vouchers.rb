FactoryBot.define do
  factory :voucher do
    client
    user
    hotel
    swap { Swap.current || create(:swap, :tomorrow) }
    check_in { self.swap.start_date }
    check_out { self.swap.end_date }
<<<<<<< HEAD
=======
    notes {
      [true, false].sample && Faker::Quote.most_interesting_man_in_the_world || nil
    }
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e

    after(:create) do |voucher|
      create(:intake, client: voucher.client, user: voucher.user)
      create(:short_intake, client: voucher.client, user: voucher.user)
    end
  end
end
