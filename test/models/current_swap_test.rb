require "test_helper"

class CurrentSwapTest < ActiveSupport::TestCase
  test "returns the current swap period" do
    current_swap = create :swap, :current
    assert current_swap == Swap.current
  end

  test "ignores periods in the future" do
    future_swap = create :swap, :future
    assert Swap.current.nil?
  end

  test "ignores periods in the past" do
    past_swap = create :swap, :past
    assert Swap.current.nil?
  end

  test "accounts for intake dates" do
    swap = create(:swap,
                  start_date: Date.current + 1,
                  end_date: Date.current + 3,
                  intake_dates: (Date.current..(Date.current + 2)).to_a)

    assert swap == Swap.current
  end
end
