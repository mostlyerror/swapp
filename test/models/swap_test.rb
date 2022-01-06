# == Schema Information
# Schema version: 20211103053452
#
# Table name: swaps
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  intake_dates :date             default([]), is an Array
#  start_date   :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class SwapTest < ActiveSupport::TestCase
  test "#stay_period" do
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current.tomorrow)
    assert Date.current.in? swap.stay_period
    assert Date.current.tomorrow.in? swap.stay_period
    assert_not Date.current.yesterday.in? swap.stay_period
    assert_not (Date.current.tomorrow + 1).in? swap.stay_period
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
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current.yesterday, intake_dates: (Date.current.yesterday..Date.current).to_a)
    assert_not swap.valid?, "end_date: #{swap.end_date} must be later than start_date: #{swap.start_date}"

    swap.end_date = Date.current.tomorrow
    assert swap.valid?
  end

  test "single-day events are invalid - events must cross at least one night" do
    swap = build_stubbed(:swap, start_date: Date.current, end_date: Date.current)
    assert_not swap.valid?
    assert_equal 0, swap.nights

    swap.end_date = Date.current.tomorrow
    assert swap.valid?
    assert_equal 1, swap.nights
  end

  test "overlapping events" do
    swap = create(:swap, start_date: Date.current.yesterday, end_date: Date.current)
    assert swap.persisted?

    swap = build_stubbed(:swap, start_date: Date.current - 2, end_date: Date.current + 2)
    assert_not swap.valid?

    swap = build_stubbed(:swap,
                         start_date: Date.current - 1,
                         end_date: Date.current)
    assert_not swap.valid?

    swap = build_stubbed(:swap,
                         start_date: Date.current,
                         end_date: Date.current + 1)
    assert_not swap.valid?

    swap = build_stubbed(:swap,
                         start_date: Date.current + 1,
                         end_date: Date.current + 2)
    assert swap.valid?
  end

  test "swap periods must have at least one day between them to be distinct" do
    create(:swap, start_date: Date.current, end_date: Date.current.tomorrow)

    swap = build_stubbed(:swap, start_date: Date.current.tomorrow, end_date: Date.current + 3)
    assert_not swap.valid?

    swap = build_stubbed(:swap, start_date: Date.current + 2, end_date: Date.current + 3)
    assert swap.valid?
  end

  test "intake_dates must be an array sorted from earliest to most recent date" do
    swap = Swap.new(
      start_date: Date.current + 1,
      end_date: Date.current + 3,
      intake_dates: (Date.current..(Date.current + 1)).to_a.reverse
    )
    assert swap.invalid?
    assert swap.errors.key? :intake_dates
  end
end
