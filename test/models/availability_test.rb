require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  test "availability date must be within swap intake period" do
    swap = build_stubbed(:swap, :tomorrow)
    av = build_stubbed(:availability, swap: swap)
    assert av.valid?

    av.date = Date.current
    refute av.date.in? swap.stay_period
    assert av.date.in? swap.intake_period
    assert av.valid?
  end


  test "one availability per date per motel per swap" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    av = create(:availability, swap: swap, motel: motel, date: swap.start_date, vacant: 1)
    assert av.persisted?
    av = build_stubbed(:availability, swap: swap, motel: motel, date: swap.start_date, vacant: 1)
    refute av.valid?
    assert av.errors.key?(:one_per_date_per_motel_per_swap)

    # skipping validations to test custom multi-column index using dates:
    # see: db/migrate/20210223163318_add_unique_index_to_availabilities.rb
    av = build(:availability, swap: swap, motel: motel, date: swap.start_date, vacant: 1)
    assert_raise(ActiveRecord::RecordNotUnique) { av.save(validate: false) }
  end

  test "availability should include motels even when they haven't responded" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    supply = RoomSupply.by_motel(swap)
    assert supply.key?(motel.id)
  end

  test "RoomSupply::by_motel" do
    Availability.destroy_all
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    swap.availabilities.create(
      motel: motel, 
      date: swap.start_date,
      vacant: 1
    )

    supply = RoomSupply.by_motel(swap)
    assert_equal(1, supply[motel.id][swap.start_date][:vacant])
    assert_nil supply[motel.id][swap.start_date + 1][:vacant]

    motel2 = create(:motel)
    swap.availabilities.create(
      motel: motel2, 
      date: swap.start_date,
      vacant: 2,
    )

    supply = RoomSupply.by_motel(swap.reload)
    assert_equal(2, supply[motel2.id][swap.start_date][:vacant])
    assert_nil supply[motel2.id][swap.start_date + 1][:vacant]
  end
end
