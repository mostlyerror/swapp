# == Schema Information
# Schema version: 20211223223312
#
# Table name: vouchers
#
#  id                        :bigint           not null, primary key
#  check_in                  :date             not null
#  check_out                 :date             not null
#  guest_ids                 :integer          default([]), is an Array
#  notes                     :text
#  num_adults_in_household   :integer
#  num_children_in_household :integer
#  number                    :string
#  voided_at                 :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  client_id                 :bigint           not null, indexed, indexed => [swap_id]
#  hotel_id                  :bigint           not null, indexed
#  swap_id                   :bigint           indexed => [client_id], indexed
#  user_id                   :bigint           not null, indexed
#  voided_by_id              :bigint           indexed
#
# Indexes
#
#  index_vouchers_on_client_id              (client_id)
#  index_vouchers_on_client_id_and_swap_id  (client_id,swap_id)
#  index_vouchers_on_hotel_id               (hotel_id)
#  index_vouchers_on_swap_id                (swap_id)
#  index_vouchers_on_user_id                (user_id)
#  index_vouchers_on_voided_by_id           (voided_by_id)
#
# Foreign Keys
#
#  fk_rails_1a4d6b99f0  (swap_id => swaps.id)
#  fk_rails_1ea81e504c  (hotel_id => hotels.id)
#  fk_rails_35b9b0ce9d  (client_id => clients.id)
#  fk_rails_3e6ca7b204  (user_id => users.id)
#  fk_rails_8c1008a5cb  (voided_by_id => users.id)
#
FactoryBot.define do
  factory :voucher do
    client
    association :issuer, factory: :user
    hotel
    swap { Swap.current || create(:swap, :tomorrow) }
    check_in { self.swap.start_date }
    check_out { self.swap.end_date }
    notes {
      [true, false].sample && FFaker::HipsterIpsum.words(20) || nil
    }

    after(:create) do |voucher|
      create(:intake, client: voucher.client, user: voucher.issuer, swap: voucher.swap)
      create(:short_intake, client: voucher.client, user: voucher.issuer, swap: voucher.swap)
    end
  end
end
