require "test_helper"

class SwapIntakeTest < ActiveSupport::TestCase
  setup do
    @swap = build_stubbed(:swap,
                          start_date: Date.current.tomorrow,
                          end_date: Date.current.tomorrow + 1,
                          intake_dates: (Date.current..Date.current.tomorrow).to_a)
  end

  test "vouchers can only be issued during swap intake period" do
    assert SwapIntake.can_issue_voucher_on?(Date.current, @swap)
    assert SwapIntake.can_issue_voucher_on?(Date.current.tomorrow, @swap)
    assert_not SwapIntake.can_issue_voucher_on?(Date.current - 1, @swap)
    assert_not SwapIntake.can_issue_voucher_on?(Date.current.tomorrow + 1, @swap)
  end
end
