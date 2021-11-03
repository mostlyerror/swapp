# == Schema Information
# Schema version: 20211103053452
#
# Table name: swaps
#
#  id           :bigint           not null, primary key
#  end_date     :date
#  intake_dates :date             default([]), is an Array
#  start_date   :date             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Swap < ApplicationRecord
  # include AASM 

  validates_presence_of :start_date, :end_date, :intake_dates
  validate :order_of_dates
  validate :overlapping_events
  validate :at_least_one_night
  validate :no_intake_on_last_night
  validate :no_unsorted_intake_dates

  has_many :vouchers
  has_many :availabilities

  def self.current
    where("LEAST(start_date, intake_dates[1]) <= ? AND end_date >= ?", Date.current, Date.current).first
  end

  def self.upcoming
    where("start_date >= ? OR intake_dates[1] >= ?", Date.current, Date.current).first
  end

  def self.current_or_upcoming
    current || upcoming
  end

  def upcoming?
    Date.current < intake_dates.first
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

  def intake_active?
    Date.current.in? intake_dates
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

    def no_intake_on_last_night
      if intake_dates.include? end_date
        return errors.add(:base, "Cannot perform intake on last day of swap period")
      end
    end

    def no_unsorted_intake_dates
      if intake_dates.sort != intake_dates
        return errors.add(:intake_dates, "Intake dates are unsorted")
      end 
    end
end
