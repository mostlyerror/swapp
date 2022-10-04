FactoryBot.define do
  factory :voucher do
    client
    association :issuer, factory: :user
    hotel
    swap { Swap.current || create(:swap, :tomorrow) }
    check_in { swap.start_date }
    check_out { swap.end_date }
    notes do
      ([true, false].sample && FFaker::HipsterIpsum.words(20)) || nil
    end
    voided_at { nil }
    voided_by { nil }

    after(:create) do |voucher|
      create(:intake, client: voucher.client, user: voucher.issuer, swap: voucher.swap)
      create(:short_intake, client: voucher.client, user: voucher.issuer, swap: voucher.swap)
    end
  end
end
