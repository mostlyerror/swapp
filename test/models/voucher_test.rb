require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  test "can't check_in before swap_period.start_date" do
    skip 'wip'
    build_stubbed(:swap_period, :current)
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
