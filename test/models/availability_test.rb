require 'test_helper'

class AvailabilityTest < ActiveSupport::TestCase
  test "availibility date must be within swap period" do
    swap = build_stubbed(:swap, :tomorrow)
    avail = build_stubbed(:availability, swap: swap)
    assert avail.valid?

    avail.date = Date.current
    refute avail.valid?
    assert avail.errors.key?(:date_must_be_within_swap_period)
  end
end
