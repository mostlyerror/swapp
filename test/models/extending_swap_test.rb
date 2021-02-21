require 'test_helper'

class ExtendingSwapTest < ActiveSupport::TestCase
  test "extending the period" do
    swap = create(:swap, :current)
    assert_equal 2, swap.nights

    swap.extend!(1)
    assert_equal 3, swap.nights

    swap.extend!(1)
    assert_equal 4, swap.nights
  end

  test "can't reduce the period, only increase" do
    swap = create(:swap, :current)
    duration = swap.duration
    assert_raises { swap.extend!(-1) }
    assert_equal duration, swap.duration
  end

  test "extending also extends vouchers" do
    swap = create(:swap, :tomorrow)
    duration = swap.duration
    voucher = create(:voucher, swap: swap)
    check_out = voucher.check_out

    swap.extend!(1)
    assert_equal duration + 1, swap.duration
    assert_equal check_out + 1, voucher.reload.check_out
  end

  test "voucher nights can't be reduced by extend" do
    swap = create(:swap, :tomorrow)
    voucher = create(:voucher, swap: swap)
    assert_raises { voucher.extend!(-1)}
  end
end
