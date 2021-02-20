require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  test "one voucher per period per client" do
    swap = create(:swap_period, :future)
    voucher = create(:voucher, swap_period: swap)
    voucher = build(:voucher, 
      swap_period: swap, 
      client: voucher.client,
      check_in: swap.start_date,
      check_out: swap.end_date,
    )
    refute voucher.valid?
    assert voucher.errors.key?(:client_id)

    voucher.client = create(:client)
    assert voucher.valid?
  end

  test "voucher dates must be in order" do
    swap = build_stubbed(:swap_period, :current)
    voucher = build_stubbed(:voucher, 
      swap_period: swap,
      check_in: swap.end_date,
      check_out: swap.start_date
    )
    refute voucher.valid?
    assert voucher.errors.key? :dates

    voucher.check_in = swap.start_date
    voucher.check_out = swap.end_date
    assert voucher.valid?
  end

  test "check_in/out only during swap period" do
    swap = build_stubbed(:swap_period, :current)
    voucher = build_stubbed(:voucher, 
      swap_period: swap,
      check_in: swap.start_date,
      check_out: swap.end_date
    )
    assert voucher.valid?

    voucher.check_in = swap.start_date - 1
    refute voucher.valid?
    assert voucher.errors.key? :check_in

    voucher.check_out = swap.end_date + 1
    refute voucher.valid?
    assert voucher.errors.key? :check_out
  end

  test "dates must be today or later on issuance" do
    swap = build_stubbed(:swap_period, :past)
    voucher = build(:voucher, 
      swap_period: swap, 
      check_in: swap.start_date, 
      check_out: swap.end_date,
    )

    refute voucher.valid?
    assert voucher.errors.key? :backdated
  end
end
