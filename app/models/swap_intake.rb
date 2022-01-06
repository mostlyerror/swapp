class SwapIntake
  def self.current_check_in_date(swap)
    return nil if !can_issue_voucher_today?
    [Date.current, swap.start_date].max
  end

  def self.can_issue_voucher_on?(date, swap)
    return false if swap.nil?
    date.in? swap.intake_dates
  end

  def self.can_issue_voucher_today?(swap)
    return false if swap.nil?
    can_issue_voucher_on? Date.current, swap
  end

  def self.first_intake_day(swap)
    swap.intake_dates.first
  end

  def self.today_is_first_intake_day?(swap)
    return false if swap.nil?
    Date.current == first_intake_day(swap)
  end

  def self.last_intake_day(swap)
    swap.intake_dates.last
  end

  def self.today_is_last_intake_day?(swap)
    return false if swap.nil?
    Date.current == last_intake_day(swap)
  end
end
