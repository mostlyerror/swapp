require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  test "availability date must be within swap period" do
    swap = build_stubbed(:swap, :tomorrow)
    avail = build_stubbed(:availability, swap: swap)
    assert avail.valid?

    avail.date = Date.current
    refute avail.valid?
    assert avail.errors.key?(:date_must_be_within_swap_period)
  end

  test "one availability per date per motel per swap" do
    skip 'wip'
  end

  test "RoomAvailability::by_motel" do
    swap = create(:swap, :tomorrow)
    motel_1 = create(:motel)
    swap.availabilities.create(
      motel: motel_1, 
      date: swap.start_date,
      rooms: 10
    )

    rooms = RoomAvailability.by_motel(swap)

    expected = Hash[ motel_1.id, Hash[swap.start_date, 10] ]
    assert_equal(expected, rooms)
    assert_equal(10, rooms[motel_1.id][swap.start_date])

    motel_2 = create(:motel)
    swap.availabilities.create(
      motel: motel_2, 
      date: swap.start_date,
      rooms: 20
    )

    rooms = RoomAvailability.by_motel(swap)

    assert_equal(10, rooms[motel_1.id][swap.start_date])
    assert_equal(20, rooms[motel_2.id][swap.start_date])
  end
end
