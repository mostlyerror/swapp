class SwapIntake
  def self.can_issue_voucher_on? date, swap
    date.in? swap.intake_period
  end

  def self.can_issue_voucher_today? swap
    can_issue_voucher_on? Date.current, swap
  end

  def self.first_intake_day swap
    swap.intake_period.first
  end

  def self.today_is_first_intake_day? swap
    Date.current == first_intake_day(swap)
  end

  def self.last_intake_day swap
    swap.intake_period.last
  end

  def self.today_is_last_intake_day? swap
    Date.current == last_intake_day(swap)
  end
end
