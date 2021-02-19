require 'test_helper'

class SwapPeriodTest < ActiveSupport::TestCase
  test "should not be deactivated if ongoing" do
  end

  test "extend must be positive integer" do
  end

  test "#duration" do
    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: Date.today)
    assert_equal swap.duration, 1, "expected 1, got: #{swap.duration}"

    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: 1.day.from_now)
    assert_equal swap.duration, 2, "expected 2, got: #{swap.duration}"
  end


  test "#nights" do
    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: 1.day.from_now)
    assert_equal swap.nights, 1
  end

  test "start/end dates make sense (start <= end)" do
    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: 1.day.ago)
    refute swap.valid?, "end_date: #{swap.end_date}  must be later than start_date: #{swap.start_date}"

    swap.end_date = 1.day.from_now
    assert swap.valid?
  end

  test "single-day events are invalid - events must cross at least one night" do
    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: Date.today)
    refute swap.valid?
    assert_equal 0, swap.nights

    swap.end_date = 1.day.from_now
    assert swap.valid?
    assert_equal 1, swap.nights
  end

  test "overlapping events" do
    swap = create(:swap_period, start_date: 1.day.ago, end_date: Date.today)
    assert swap.persisted?

    swap = build_stubbed(:swap_period, start_date: 2.days.ago, end_date: 2.days.from_now )
    refute swap.valid?

    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: 1.day.from_now)
    refute swap.valid?
    swap.start_date = 1.day.from_now
    swap.end_date = 2.days.from_now
    assert swap.valid?

    swap = build_stubbed(:swap_period, start_date: 2.days.ago, end_date: 1.day.ago)
    refute swap.valid?
    swap.start_date = 3.days.ago
    swap.end_date = 2.days.ago
    assert swap.valid?
  end

  test "swap periods must have at least one day between them to be distinct" do
    create(:swap_period, start_date: Date.today, end_date: Date.tomorrow)
    swap = build_stubbed(:swap_period, start_date: 1.day.from_now, end_date: 3.days.from_now)
    refute swap.valid?

    swap.start_date = 2.days.from_now
    assert swap.valid?
  end
end
