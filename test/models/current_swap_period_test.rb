require 'test_helper'

class CurrentSwapPeriodTest < ActiveSupport::TestCase
  test "::current returns ongoing event" do
    refute SwapPeriod.current

    # past (ended before today)
    SwapPeriod.destroy_all
    swap = create(:swap_period, :past)
    refute SwapPeriod.current == swap

    # ending today
    SwapPeriod.destroy_all
    swap = create(:swap_period, start_date: 1.day.ago, end_date: Date.today)
    assert_equal swap, SwapPeriod.current

    # straddling today
    SwapPeriod.destroy_all
    swap = create(:swap_period, :current)
    assert_equal swap, SwapPeriod.current

    # starting today
    SwapPeriod.destroy_all
    swap = create(:swap_period, start_date: Date.today, end_date: 1.day.from_now)
    assert_equal swap, SwapPeriod.current

    # starting tomorrow is still "current"
    SwapPeriod.destroy_all
    swap = create(:swap_period, start_date: Date.tomorrow, end_date: 2.days.from_now)
    assert_equal swap, SwapPeriod.current

    # future (starts after today)
    SwapPeriod.destroy_all
    swap = create(:swap_period, :future)
    refute SwapPeriod.current == swap
  end

  test "::current returns ongoing event when there's also a future event planned" do
    present = create(:swap_period, :current)
    assert_equal SwapPeriod.current, present

    future = create(:swap_period, :future)
    assert_equal SwapPeriod.current, present
  end
end
