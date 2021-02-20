class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel
  belongs_to :swap_period

  validates_presence_of :check_in, :check_out
  validates_uniqueness_of :client_id, scope: :swap_period_id
  validate :dates_must_be_today_or_later_when_issued, on: :create
  validate :order_of_dates, :dates_must_fall_within_swap_period

  after_create :save_number

  private 
    def save_number
      self.number = "AH%.5d" % id
      save!
    end

    def order_of_dates
      if check_out && (check_out < check_in)
        errors.add(:dates, "check_out: #{check_out} must be same day or later than check_in: #{check_in}")
      end
    end

    def dates_must_be_today_or_later_when_issued
      if (check_in && (check_in < Date.current)) or (check_out && (check_out < Date.current))
        errors.add(:backdated, "Can't issue backdated voucher dates")
      end
    end

    def dates_must_fall_within_swap_period
      if swap_period && !(check_in.in? swap_period.swap_period)
        errors.add(:check_in, "check_in (#{check_in}) does not fall within swap period: #{swap_period.swap_period}")
      end

      if swap_period && !(check_out.in? swap_period.swap_period)
        errors.add(:check_out, "check_out (#{check_out}) does not fall within swap period: #{swap_period.swap_period}")
      end
    end
end
