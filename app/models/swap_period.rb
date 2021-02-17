class SwapPeriod < ApplicationRecord
  validates_presence_of :start_date, :end_date
  validate :order_of_dates
  validate :overlapping_events

  def self.current
    where("start_date <= ? AND end_date >= ?", Date.today, Date.today).first
  end

  def duration
    ((end_date - start_date) + 1).to_i
  end
  
  private 

    def order_of_dates
      if end_date < start_date
        errors.add(:end_date, "end_date: #{end_date} must be same day or later than start_date: #{start_date}")
      end
    end

    def overlapping_events
      overlapping = self.class.where("start_date <= ? AND ? <= end_date", end_date, start_date)
      if overlapping.present?
        errors.add(:overlapping, "can't overlap other swap period: #{overlapping.first}")
      end
    end
end
