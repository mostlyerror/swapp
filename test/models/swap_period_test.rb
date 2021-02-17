require 'test_helper'

class SwapPeriodTest < ActiveSupport::TestCase
  test "::current returns ongoing event" do
    refute SwapPeriod.current

    # past (ended before today)
    swap = create(:swap_period, :past)
    refute SwapPeriod.current == swap

    # ending today
    swap = create(:swap_period, start_date: 1.day.ago, end_date: Date.today)
    assert_equal swap, SwapPeriod.current

    # straddling today
    swap = create(:swap_period, :current)
    assert_equal swap, SwapPeriod.current

    # starting today
    swap = create(:swap_period, start_date: Date.today, end_date: 1.day.from_now)
    refute SwapPeriod.current == swap

    # future (starts after today)
    swap = create(:future)
    refute SwapPeriod.current == swap
  end
end
