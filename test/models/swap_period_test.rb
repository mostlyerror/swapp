require 'test_helper'

class SwapPeriodTest < ActiveSupport::TestCase
  test "#duration" do
    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: Date.today)
    assert_equal swap.duration, 1, "expected 1, got: #{swap.duration}"

    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: 1.day.from_now)
    assert_equal swap.duration, 2, "expected 2, got: #{swap.duration}"
  end

  test "start/end dates make sense (start <= end)" do
    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: 1.day.ago)
    refute swap.valid?, "end_date: #{swap.end_date}  must be later than start_date: #{swap.start_date}"

    swap.end_date = 1.day.from_now
    assert swap.valid?
  end

  test "single-day events are valid" do
    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: Date.today)
    assert swap.valid?

    swap = build_stubbed(:swap_period, start_date: 1.day.ago, end_date: 1.day.ago)
    assert swap.valid?

    swap = build_stubbed(:swap_period, start_date: 1.day.from_now, end_date: 1.day.from_now)
    assert swap.valid?
  end

  test "overlapping events" do
    swap = create(:swap_period, start_date: 1.day.ago, end_date: Date.today)
    assert swap.persisted?

    swap = build_stubbed(:swap_period, start_date: Date.today, end_date: 1.day.from_now)
    refute swap.valid?

    swap = build_stubbed(:swap_period, start_date: 2.days.ago, end_date: 1.day.ago)
    refute swap.valid?
  end

  test "swap periods must have at least one day between them to be distinct" do
    swap = SwapPeriod.create(start_date: Date.today, end_date: Date.tomorrow)
    assert swap.persisted?

    swap = build_stubbed(:swap_period, start_date: Date.tomorrow, end_date: Date.tomorrow + 1)
    refute swap.valid?

    swap.start_date = Date.tomorrow + 1
    assert swap.valid?
  end

  test "::current returns ongoing event" do
    refute SwapPeriod.current

    # past (ended before today)
    swap = create(:swap_period, :past)
    refute SwapPeriod.current == swap

    # ending today
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
