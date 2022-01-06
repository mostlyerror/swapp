# == Schema Information
# Schema version: 20211106161846
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
require "test_helper"

class AvailabilityTest < ActiveSupport::TestCase
  test "availability date must be within swap intake period" do
    swap = build_stubbed(:swap, :tomorrow)
    av = build_stubbed(:availability, swap: swap)
    assert av.valid?

    av.date = Date.current
    assert_not av.date.in? swap.stay_period
    assert av.date.in? swap.intake_dates
    assert av.valid?
  end

  test "one availability per date per hotel per swap" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    av = create(:availability, swap: swap, hotel: hotel, date: swap.start_date, vacant: 1)
    assert av.persisted?
    av = build_stubbed(:availability, swap: swap, hotel: hotel, date: swap.start_date, vacant: 1)
    assert_not av.valid?
    assert av.errors.key?(:one_per_date_per_hotel_per_swap)

    # skipping validations to test custom multi-column index using dates:
    # see: db/migrate/20210223163318_add_unique_index_to_availabilities.rb
    av = build(:availability, swap: swap, hotel: hotel, date: swap.start_date, vacant: 1)
    assert_raise(ActiveRecord::RecordNotUnique) { av.save(validate: false) }
  end

  test "availability should include hotels even when they haven't responded" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    supply = RoomSupply.by_hotel(swap)
    assert supply.key?(hotel.id)
  end

  test "RoomSupply::by_hotel" do
    Availability.destroy_all
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    swap.availabilities.create(
      hotel: hotel,
      date: swap.start_date,
      vacant: 1
    )

    supply = RoomSupply.by_hotel(swap)
    assert_equal(1, supply[hotel.id][swap.start_date][:vacant])
    assert_nil supply[hotel.id][swap.start_date + 1][:vacant]

    hotel2 = create(:hotel)
    swap.availabilities.create(
      hotel: hotel2,
      date: swap.start_date,
      vacant: 2
    )

    supply = RoomSupply.by_hotel(swap.reload)
    assert_equal(2, supply[hotel2.id][swap.start_date][:vacant])
    assert_nil supply[hotel2.id][swap.start_date + 1][:vacant]
  end
end
