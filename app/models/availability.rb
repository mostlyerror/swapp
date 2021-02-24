class Availability < ApplicationRecord
  belongs_to :motel
  belongs_to :swap

  validates_associated :swap
  validates_presence_of :date
  validates :vacant, :numericality => { :greater_than_or_equal_to => 0 }
  validate :date_must_be_within_swap_period, :one_per_date_per_motel_per_swap

  private 
    def date_must_be_within_swap_period
      if swap.present? && date.present? && !date.in?(swap.stay_period)
        errors.add(:date_must_be_within_swap_period, 'asdf')
      end
    end

    def one_per_date_per_motel_per_swap
      if avail = self.class.where(swap: swap, date: date, motel: motel).first.present?
        errors.add(:one_per_date_per_motel_per_swap, "Availability entry already exists: #{avail}")
      end
    end
end
