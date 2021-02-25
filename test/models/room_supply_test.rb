require 'test_helper'

class RoomSupplyTest < ActiveSupport::TestCase
  test "vouchers_remaining_today" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 0, supply[motel.id]

    motel2 = create(:motel)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 0, supply[motel2.id]

    av = create(:availability, swap: swap, motel: motel, date: swap.start_date)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 1, supply[motel.id]

    create(:voucher, swap: swap, motel: motel)
    supply = RoomSupply.vouchers_remaining_today(swap)
    assert_equal 0, supply[motel.id]
  end

  test "latest vacancies" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    motel2 = create(:motel)
    supply = RoomSupply.latest_vacancies(swap)
    assert_equal 0, supply[motel.id]

    av = create(:availability, vacant: 1, swap: swap, motel: motel, date: swap.start_date)
    supply = RoomSupply.latest_vacancies(swap)
    assert_equal av.vacant, supply[motel.id]

    av = create(:availability, vacant: 10, swap: swap, motel: motel2, date: swap.start_date)
    supply = RoomSupply.latest_vacancies(swap)
    assert_equal 1, supply[motel.id]
    assert_equal 10, supply[motel2.id]
  end

  test "vouchers issued today" do
    swap = create(:swap, :tomorrow)
    motel = create(:motel)
    supply = RoomSupply.vouchers_issued_today(swap)
    assert_equal 0, supply[motel.id]

    create(:voucher, swap: swap, motel: motel)
    supply = RoomSupply.vouchers_issued_today(swap)
    assert_equal 1, supply[motel.id]

    create(:voucher, swap: swap, motel: motel)
    supply = RoomSupply.vouchers_issued_today(swap)
    assert_equal 2, supply[motel.id]
  end
end
