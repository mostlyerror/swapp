require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  test "availability date must be within swap period" do
    swap = build_stubbed(:swap, :tomorrow)
    av = build_stubbed(:availability, swap: swap)
    assert av.valid?

    av.date = Date.current
    refute av.valid?
    assert av.errors.key?(:date_must_be_within_swap_period)
  end


  test "one availability per date per motel per swap" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    av = create(:availability, swap: swap, motel: motel, date: swap.start_date, rooms: 1)
    assert av.persisted?
    av = build_stubbed(:availability, swap: swap, motel: motel, date: swap.start_date, rooms: 1)
    refute av.valid?
    assert av.errors.key?(:one_per_date_per_motel_per_swap)

    # skipping validations to test custom multi-column index using dates:
    # see: db/migrate/20210223163318_add_unique_index_to_availabilities.rb
    av = build(:availability, swap: swap, motel: motel, date: swap.start_date, rooms: 1)
    assert_raise(ActiveRecord::RecordNotUnique) { av.save(validate: false) }
  end

  test "availability should include motels even when they haven't responded" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    rooms = RoomAvailability.by_motel(swap)
    assert rooms.key?(motel)
  end

  test "RoomAvailability::by_motel" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    swap.availabilities.create(
      motel: motel, 
      date: swap.start_date,
      rooms: 1
    )

    rooms = RoomAvailability.by_motel(swap)
    assert_equal(1, rooms[motel][swap.start_date])
    assert_nil rooms[motel][swap.start_date + 1]

    motel2 = create(:motel)
    swap.availabilities.create(
      motel: motel2, 
      date: swap.start_date,
      rooms: 2,
    )

    rooms = RoomAvailability.by_motel(swap.reload)
    assert_equal(2, rooms[motel2][swap.start_date])
    assert_nil rooms[motel][swap.start_date + 1]
  end
end
