require 'test_helper'

class RoomSupplyTest < ActiveSupport::TestCase
  test "public API filters out inactive hotels" do
    swap = create(:swap, :tomorrow)
    active_hotel = create(:hotel)
    inactive_hotel = create(:hotel, active: false)

    hotel_ids = RoomSupply.latest_vacancies(swap).keys
    assert hotel_ids.include?(active_hotel.id)
    assert_not hotel_ids.include?(inactive_hotel.id)

    hotel_ids = RoomSupply.vouchers_issued_today(swap).keys
    assert hotel_ids.include?(active_hotel.id)
    assert_not hotel_ids.include?(inactive_hotel.id)

    hotel_ids = RoomSupply.vouchers_remaining_today(swap).keys
    assert hotel_ids.include?(active_hotel.id)
    assert_not hotel_ids.include?(inactive_hotel.id)
  end

  test "ignores availabilities created today that are no longer relevant (swap window moved)" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    assert_equal 0, RoomSupply.vouchers_remaining_today(swap)[hotel.id]
    av = swap.availabilities.create(hotel: hotel, date: Date.current, vacant: 10)
    assert_equal 10, RoomSupply.vouchers_remaining_today(swap)[av.hotel_id]

    # move the swap period up by two days, previous availabilities are now dangling
    swap.update(
      start_date: swap.start_date + 2,
      end_date: swap.end_date + 2,
      intake_dates: swap.intake_dates.map {|d| d + 2 }
    )

    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 0, supply[hotel.id]
    assert_equal 0, supply[swap.availabilities.first.hotel_id]
  end

  test "vouchers_remaining_today" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 0, supply[hotel.id]

    hotel2 = create(:hotel)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 0, supply[hotel2.id]

    av = create(:availability, swap: swap, hotel: hotel, date: swap.start_date)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 1, supply[hotel.id]

    create(:voucher, swap: swap, hotel: hotel)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 0, supply[hotel.id]
  end

  test "latest vacancies" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    hotel2 = create(:hotel)
    supply = RoomSupply.latest_vacancies(swap)
    assert_equal 0, supply[hotel.id]

    av = create(:availability, vacant: 1, swap: swap, hotel: hotel, date: swap.start_date)
    supply = RoomSupply.latest_vacancies(swap)
    assert_equal av.vacant, supply[hotel.id]

    av = create(:availability, vacant: 10, swap: swap, hotel: hotel2, date: swap.start_date)
    supply = RoomSupply.latest_vacancies(swap)
    assert_equal 1, supply[hotel.id]
    assert_equal 10, supply[hotel2.id]
  end

  test "vouchers issued today" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    supply = RoomSupply.vouchers_issued_today(swap)
    assert_equal 0, supply[hotel.id]

    create(:voucher, swap: swap, hotel: hotel)
    supply = RoomSupply.vouchers_issued_today(swap)
    assert_equal 1, supply[hotel.id]

    create(:voucher, swap: swap, hotel: hotel)
    supply = RoomSupply.vouchers_issued_today(swap)
    assert_equal 2, supply[hotel.id]
  end
end
