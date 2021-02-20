class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel
  belongs_to :swap_period

  validates_presence_of :check_in, :check_out
  validates_uniqueness_of :client_id, scope: :swap_period_id
  validate :dates_must_be_today_or_later_when_issued, on: :create
  validate :order_of_dates, :dates_must_fall_within_swap_period, :at_least_one_night_remaining

  after_create :save_number

  def duration
    ((check_out - check_in) + 1).to_i
  end

  def nights 
    duration - 1
  end

  def nights_remaining
    [(check_out -  Date.current).to_i, 0].max
  end

  def extend nights
    self.check_out = self.check_out.to_date + nights.to_i.days
    self
  end

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
      if (check_in < Date.current) or (check_out < Date.current)
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

    def at_least_one_night_remaining
      if nights_remaining < 1
        return errors.add(:nights, "duration: (#{nights_remaining} nights remaining) must be for at least one night")
      end
    end
end
