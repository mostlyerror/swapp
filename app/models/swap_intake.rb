class SwapIntake
  def self.can_issue_voucher_on? date, swap
    date.in? swap.intake_period
  end

  def self.can_issue_voucher_today? swap
    can_issue_voucher_on? Date.today, swap
  end
end
