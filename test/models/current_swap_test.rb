require 'test_helper'

class CurrentSwapTest < ActiveSupport::TestCase
  # returns the swap period that encompasses the current day
  test "returns the current swap period" do
    current_swap = create :swap, :current  
    assert current_swap == Swap.current
  end

  test "swap period occurs in the future" do
    future_swap = create :swap, :future
    assert Swap.current == nil
  end

  test "swap period occurs in the past" do
    past_swap = create :swap, :past
    assert Swap.current == nil
  end

end
