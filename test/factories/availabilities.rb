# == Schema Information
# Schema version: 20211103053452
#
# Table name: availabilities
#
#  id         :bigint           not null, primary key
#  date       :date             not null, indexed => [hotel_id, swap_id]
#  vacant     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hotel_id   :bigint           not null, indexed, indexed => [swap_id, date]
#  swap_id    :bigint           not null, indexed => [hotel_id, date], indexed
#
# Indexes
#
#  index_availabilities_on_hotel_id                       (hotel_id)
#  index_availabilities_on_hotel_id_and_swap_id_and_date  (hotel_id,swap_id,date) UNIQUE
#  index_availabilities_on_swap_id                        (swap_id)
#
# Foreign Keys
#
#  fk_rails_6b15febea0  (hotel_id => hotels.id)
#  fk_rails_ccaa540134  (swap_id => swaps.id)
#
FactoryBot.define do
  factory :availability do
    hotel
    swap
    vacant { 1 }
    date { self.swap.intake_dates.first }
  end
end
