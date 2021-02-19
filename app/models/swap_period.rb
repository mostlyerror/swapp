class SwapPeriod < ApplicationRecord
  validates_presence_of :start_date, :end_date
  validate :order_of_dates
  validate :at_least_one_night
  validate :overlapping_events

  def self.current
    where("start_date <= ? AND end_date >= ?", Date.today, Date.today).first
  end

  def duration
    ((end_date - start_date) + 1).to_i
  end

  def nights 
    duration - 1
  end

  def remaining_nights
    [(end_date -  Date.today.to_date).to_i, 0].max
  end

  def extend nights
    self.end_date = self.end_date.to_date + nights.to_i.days
    self
  end
  
  private 

    def order_of_dates
      if end_date < start_date
        errors.add(:end_date, "end_date: #{end_date} must be same day or later than start_date: #{start_date}")
      end
    end

    def at_least_one_night 
      if nights <= 0
        errors.add(:duration, "duration: (#{nights} nights) must be for at least one night")
      end
    end


    def overlapping_events
      overlapping = self.class.where("id <> ? AND start_date <= ? AND ? <= end_date", self.id, end_date, start_date)
      if overlapping.present?
        errors.add(:overlapping, "can't overlap other swap period: #{overlapping.first}")
      end
    end
end
