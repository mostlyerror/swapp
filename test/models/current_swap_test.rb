require 'test_helper'

class CurrentSwapTest < ActiveSupport::TestCase
  test "::current returns ongoing event" do
    refute Swap.current

    # past (ended before today)
    Swap.destroy_all
    swap = create(:swap, :past)
    refute Swap.current == swap

    # ending today
    Swap.destroy_all
    swap = create(:swap, start_date: 1.day.ago, end_date: Date.current)
    assert_equal swap, Swap.current

    # straddling today
    Swap.destroy_all
    swap = create(:swap, :current)
    assert_equal swap, Swap.current

    # starting today
    Swap.destroy_all
    swap = create(:swap, start_date: Date.current, end_date: 1.day.from_now)
    assert_equal swap, Swap.current

    # starting tomorrow is still "current"
    Swap.destroy_all
    swap = create(:swap, start_date: Date.current.tomorrow, end_date: 2.days.from_now)
    assert_equal swap, Swap.current

    # starts tomorrow 
    Swap.destroy_all
    swap = create(:swap, :tomorrow)
    assert Swap.current == swap
  end

  test "::current returns ongoing event when there's also a future event planned" do
    present = create(:swap, :current)
    assert_equal Swap.current, present

    future = create(:swap, :future)
    assert_equal Swap.current, present

    past = create(:swap, :past)
    assert_equal Swap.current, present
  end
end
