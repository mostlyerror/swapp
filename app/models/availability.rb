class Availability < ApplicationRecord
  belongs_to :motel
  belongs_to :swap

  validates_associated :swap
  validates_presence_of :date
  validates :rooms, :numericality => { :greater_than_or_equal_to => 0 }
  validate :date_must_be_within_swap_period

  private 

    def date_must_be_within_swap_period
      if swap.present? && date.present? && !date.in?(swap.stay_period)
        errors.add(:date_must_be_within_swap_period, 'asdf')
      end
    end
end
