require 'test_helper'

class SwapTest < ActiveSupport::TestCase
  test "#stay_period" do
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current.tomorrow)
    assert Date.current.in? swap.stay_period
    assert Date.current.tomorrow.in? swap.stay_period
    refute Date.current.yesterday.in? swap.stay_period
    refute (Date.current.tomorrow + 1).in? swap.stay_period
  end

  test "#duration" do
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current)
    assert_equal swap.duration, 1, "expected 1, got: #{swap.duration}"
  end

  test "#nights" do
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current.tomorrow)
    assert_equal swap.nights, 1
  end

  test "start/end dates make sense (start <= end)" do
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current.yesterday)
    refute swap.valid?, "end_date: #{swap.end_date}  must be later than start_date: #{swap.start_date}"

    swap.end_date = Date.current.tomorrow
    assert swap.valid?
  end

  test "single-day events are invalid - events must cross at least one night" do
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current)
    refute swap.valid?
    assert_equal 0, swap.nights

    swap.end_date = Date.current.tomorrow
    assert swap.valid?
    assert_equal 1, swap.nights
  end

  test "overlapping events" do
    swap = create(:swap, start_date: Date.current.yesterday, end_date: Date.current)
    assert swap.persisted?

    swap = build_stubbed(:swap, start_date: Date.current - 2, end_date: Date.current + 2)
    refute swap.valid?

    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current.tomorrow)
    refute swap.valid?
    swap.start_date = Date.current.tomorrow
    swap.end_date = Date.current + 2
    assert swap.valid?

    swap = build_stubbed(:swap, start_date: Date.current - 2, end_date: Date.current.yesterday)
    refute swap.valid?
    swap.start_date = Date.current - 3
    swap.end_date = Date.current - 2
    assert swap.valid?
  end

  test "swap periods must have at least one day between them to be distinct" do
    create(:swap, start_date: Date.current, end_date: Date.current.tomorrow)

    swap = build_stubbed(:swap, start_date: Date.current.tomorrow, end_date: Date.current + 3)
    refute swap.valid?

    swap.start_date = Date.current + 2
    assert swap.valid?
  end
end
