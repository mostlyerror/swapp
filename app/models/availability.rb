class Availability < ApplicationRecord
  belongs_to :motel
  belongs_to :swap

  validate :date_must_be_within_swap_period

  private 
    def date_must_be_within_swap_period
      if !date.in? swap.stay_period
        errors.add(:date_must_be_within_swap_period, 'asdf')
      end
    end
end
