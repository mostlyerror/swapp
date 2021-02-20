require 'test_helper'

class SwapIntakeTest < ActiveSupport::TestCase
  setup do
    @swap = build_stubbed(:swap_period, start_date: Date.current.tomorrow, end_date: Date.current.tomorrow  + 1)
  end

  test "can issue vouchers 1 day before @swap period start" do
    assert SwapIntake.can_issue_voucher_today?(@swap)
  end

  test "can issue vouchers 1 day before @swap period end" do
    assert SwapIntake.can_issue_voucher_on?(@swap.end_date - 1.day, @swap)
  end

  test "can't issue vouchers before or after intake period" do
    assert SwapIntake.can_issue_voucher_on?(@swap.start_date - 1.day, @swap)
    refute SwapIntake.can_issue_voucher_on?(@swap.start_date - 2.days, @swap)

    assert SwapIntake.can_issue_voucher_on?(@swap.end_date - 1.day, @swap)
    refute SwapIntake.can_issue_voucher_on?(@swap.end_date + 1.days, @swap)
  end

  test "can't issue voucher on last day of @swap period" do
    refute SwapIntake.can_issue_voucher_on?(@swap.end_date, @swap)
  end
end
