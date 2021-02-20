require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  test "can't check_in before swap_period.start_date" do
    build_stubbed(:swap_period, :current)
  end

  test "can't issue vouchers for the past" do
    swap = build_stubbed(:swap_period, :past)
    voucher = build_stubbed(:voucher, swap_period: swap, 
                  check_in: swap.start_date,
                  check_out: swap.end_date,
                 )
    assert voucher.valid?
    refute voucher.errors

  end
end
