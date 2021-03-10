class Swap < ApplicationRecord
  include AASM

  aasm do
  end
  include AASM 

  validates_presence_of :start_date, :end_date
  validate :order_of_dates
  validate :overlapping_events
  validate :at_least_one_night

  has_many :vouchers
  has_many :availabilities

  aasm do
    state :inactive, initial: true
    state :active

    event :activate do
      transitions from: :inactive, to: :active
    end

    event :deactivate do
      transitions from: :active, to: :inactive
    end
  end

  def self.current
    where("start_date <= ? AND end_date >= ?", Date.current.tomorrow, Date.current).first
  end

  def swap
    start_date..end_date
  end

  def intake_period
    (start_date - 1.day)..(end_date - 1.day)
  end

  def intake_start_date
    intake_period.first
  end

  def intake_end_date
    intake_period.last
  end

  def stay_period
    start_date..end_date
  end

  def duration
    ((end_date - start_date) + 1).to_i
  end

  def nights 
    duration - 1
  end

  def nights_remaining
    [(end_date -  Date.current.to_date).to_i, 0].max
  end

  def intake_ended?
    nights_remaining <= 0
  end

  def extend! nights
    nights = nights.to_i
    raise :cannot_extend_swap_by_negative_number_of_days if nights.negative?

    self.transaction do
      self.end_date = self.end_date.to_date + nights
      save!
      self.vouchers.each { |voucher| voucher.extend!(nights) }
    end
    self
  end

  def to_s
    "#{id}|#{start_date.to_date}|#{end_date.to_date}"
  end
  
  private 

    def order_of_dates
      if end_date&.< start_date
        errors.add(:base, "end_date: #{end_date} must be same day or later than start_date: #{start_date}")
      end
    end

    def at_least_one_night 
      if start_date.nil?
        return errors.add(:base, "start_date must not be nil")
      end

      if end_date.nil?
        return errors.add(:base, "end_date must not be nil")
      end

      if nights <= 0
        return errors.add(:base, "duration: (#{nights} nights) must be for at least one night")
      end
    end

    def overlapping_events
      overlapping = self.class.where("start_date <= ? AND ? <= end_date", end_date, start_date)
        .reject { |sw| sw == self }
      if overlapping.present?
        errors.add(:overlapping, "can't overlap other swap period: #{overlapping.first}")
      end
    end
end
