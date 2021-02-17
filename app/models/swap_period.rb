class SwapPeriod < ApplicationRecord
  validates_presence_of :start_date, :end_date
  validate :order_of_dates
  validate :overlapping_events
  validate :at_least_one_night

  def self.current
    where("start_date <= ? AND end_date >= ?", Date.today, Date.today).first
  end

  def duration
    ((end_date - start_date) + 1).to_i
  end

  # maybe you can't actually have a single day swap period
  def num_nights
    duration - 1
  end
  
  private 

    def at_least_one_night 
      if num_nights <= 0
        errors.add(:duration, "duration: (#{num_nights} nights) must be for at least one night")
      end
    end

    def order_of_dates
      if end_date < start_date
        errors.add(:end_date, "end_date: #{end_date} must be same day or later than start_date: #{start_date}")
      end
    end

    def overlapping_events
      overlapping = self.class.where("id <> ? AND start_date <= ? AND ? <= end_date", self.id, end_date, start_date)
      if overlapping.present?
        errors.add(:overlapping, "can't overlap other swap period: #{overlapping.first}")
      end
    end
end
