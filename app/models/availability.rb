class Availability < ApplicationRecord
  belongs_to :hotel
  belongs_to :swap

  validates_associated :swap
  validates_presence_of :date
  validates :vacant, :numericality => { :greater_than_or_equal_to => 0 }
  validate :date_must_be_within_swap_intake_period, :one_per_date_per_hotel_per_swap

  private 
    def date_must_be_within_swap_intake_period
      if swap.present? && date.present? && !date.in?(swap.intake_period)
        errors.add(:date_must_be_within_swap_intake_period)
      end
    end

    def one_per_date_per_hotel_per_swap
      if avail = self.class.where(swap: swap, date: date, hotel: hotel).first.present?
        errors.add(:one_per_date_per_hotel_per_swap, "Availability entry already exists: #{avail}")
      end
    end
end
