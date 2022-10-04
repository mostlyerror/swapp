require "test_helper"

class VoucherGuestsTest < ActiveSupport::TestCase
  test "prior guests" do
    Timecop.travel(Date.current - 7)
    client = create(:client)
    assert_equal(0, client.prior_guests.size)

    swap = create(:swap, :tomorrow)
    guests = create_list(:client, 2)
    voucher = create(:voucher, client: client, swap: swap, guest_ids: guests.map(&:id))

    assert_equal(2, voucher.guests.size)
    client.vouchers.reload
    assert_equal(2, client.prior_guests.size)
    Timecop.return

    Timecop.travel(Date.current - 3)
    assert_equal(2, client.prior_guests.size)

    swap = create(:swap, :tomorrow)
    guests = create_list(:client, 2)
    voucher = create(:voucher, client: client, swap: swap, guest_ids: guests.map(&:id))

    assert_equal(2, voucher.guests.size)
    client.vouchers.reload
    assert_equal(4, client.prior_guests.size)
    Timecop.return
  end
end
