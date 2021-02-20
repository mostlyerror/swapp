class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel
  belongs_to :swap_period

  validate :dates_must_be_today_or_later_when_issued, on: :create
  validate :dates_must_fall_within_swap_period

  after_create :save_number

  private 
    def save_number
      self.number = "AH%.5d" % id
      save!
    end

    def dates_must_be_today_or_later_when_issued
      if (check_in < Date.current) or (check_out < Date.current)
        errors.add(:backdated, "Can't issue backdated voucher dates")
      end
    end

    def dates_must_fall_within_swap_period
      if !check_in.in? swap_period.swap_period
        errors.add(:check_in, "check_in (#{check_in}) does not fall within swap period: #{swap_period.swap_period}")
      end

      if !check_out.in? swap_period.swap_period
        errors.add(:check_out, "check_out (#{check_out}) does not fall within swap period: #{swap_period.swap_period}")
      end
    end
end
