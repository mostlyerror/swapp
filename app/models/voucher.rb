class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel
  belongs_to :swap

  validates_presence_of :check_in, :check_out
  validates_uniqueness_of :client_id, scope: :swap_id
  validate :dates_must_be_today_or_later_when_issued, on: :create
  validate :order_of_dates, :dates_must_fall_within_swap
  # , :at_least_one_night_remaining

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

  def extend! nights
    nights = nights.to_i
    raise :cannot_extend_voucher_by_negative_number_of_days if nights.negative?

    self.check_out = self.check_out + nights
    save!
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
      if check_in.blank?
        return errors.add(:check_in, "Must provide a check in date")
      end

      if check_out.blank?
        return errors.add(:check_out, "Must provide a check out date")
      end

      if (check_in < Date.current)
        errors.add(:check_in, "Can't issue backdated voucher dates")
      end

      if (check_out < Date.current)
        errors.add(:check_out, "Can't issue backdated voucher dates")
      end
    end

    def dates_must_fall_within_swap
      if swap && !(check_in.in? swap.swap)
        errors.add(:check_in, "check_in (#{check_in}) does not fall within swap period: #{swap.swap}")
      end

      if swap && !(check_out.in? swap.swap)
        errors.add(:check_out, "check_out (#{check_out}) does not fall within swap period: #{swap.swap}")
      end
    end

    # def at_least_one_night_remaining
    #   if nights_remaining < 1
    #     return errors.add(:nights, "duration: (#{nights_remaining} nights remaining) must be for at least one night")
    #   end
    # end
end
