require 'test_helper'

class ExtendingSwapPeriodTest < ActiveSupport::TestCase
  test "extending the period" do
    swap = build_stubbed(:swap_period, :current)
    assert_equal 2, swap.nights

    swap.extend(1)
    assert_equal 3, swap.nights

    swap.extend(1)
    assert_equal 4, swap.nights
  end
end
