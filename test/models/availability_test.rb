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

  test "Swap#motel_availability" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    swap.availabilities.create(
      motel: motel, 
      date: swap.start_date,
      rooms: 10
    )

    assert_equal({"#{swap.start_date}": {name: motel.name, rooms: 10}}, swap.motel_availability)
  end
end
