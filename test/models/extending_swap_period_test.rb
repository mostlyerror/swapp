require 'test_helper'

class ExtendingSwapPeriodTest < ActiveSupport::TestCase
  test "extending the period" do
    swap = build_stubbed(:swap_period, :current)
    assert_equal 2, swap.num_nights

    swap.extend(1)
    assert_equal 3, swap.num_nights

    swap.extend(1)
    assert_equal 4, swap.num_nights
  end
end
