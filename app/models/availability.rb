# == Schema Information
# Schema version: 20211106161846
#
# Table name: availabilities
#
#  id         :bigint           not null, primary key
#  date       :date             not null, indexed => [hotel_id, swap_id]
#  vacant     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  hotel_id   :bigint           not null, indexed, indexed => [swap_id, date]
#  swap_id    :bigint           not null, indexed => [hotel_id, date], indexed
#
# Indexes
#
#  index_availabilities_on_hotel_id                       (hotel_id)
#  index_availabilities_on_hotel_id_and_swap_id_and_date  (hotel_id,swap_id,date) UNIQUE
#  index_availabilities_on_swap_id                        (swap_id)
#
# Foreign Keys
#
#  fk_rails_6b15febea0  (hotel_id => hotels.id)
#  fk_rails_ccaa540134  (swap_id => swaps.id)
#
class Availability < ApplicationRecord
  has_logidze
  belongs_to :hotel
  belongs_to :swap

  validates_associated :swap
  validates_presence_of :date
  validates :vacant, :numericality => { :greater_than_or_equal_to => 0 }
  validate :date_must_be_within_swap_intake_period, :one_per_date_per_hotel_per_swap

  private 
    def date_must_be_within_swap_intake_period
      if swap.present? && date.present? && !date.in?(swap.intake_dates)
        errors.add(:date_must_be_within_swap_intake_period)
      end
    end

    def one_per_date_per_hotel_per_swap
      if avail = self.class.where(swap: swap, date: date, hotel: hotel).first.present?
        errors.add(:one_per_date_per_hotel_per_swap, "Availability entry already exists: #{avail}")
      end
    end
end
