require 'test_helper'

class SwapIntakeTest < ActiveSupport::TestCase
  setup do
    @swap = build_stubbed(:swap, 
                          start_date: Date.current.tomorrow, 
                          end_date: Date.current.tomorrow + 1,
                          intake_start_date: Date.current,
                          intake_end_date: Date.current.tomorrow 
                         )
  end

  test "vouchers can only be issued during swap intake period" do
    assert SwapIntake.can_issue_voucher_on?(Date.current, @swap)
    assert SwapIntake.can_issue_voucher_on?(Date.current.tomorrow, @swap)
    refute SwapIntake.can_issue_voucher_on?(Date.current - 1, @swap)
    refute SwapIntake.can_issue_voucher_on?(Date.current.tomorrow + 1, @swap)
  end
end
