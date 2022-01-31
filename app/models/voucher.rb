# == Schema Information
# Schema version: 20211223223312
#
# Table name: vouchers
#
#  id                        :bigint           not null, primary key
#  check_in                  :date             not null
#  check_out                 :date             not null
#  guest_ids                 :integer          default([]), is an Array
#  notes                     :text
#  num_adults_in_household   :integer
#  num_children_in_household :integer
#  number                    :string
#  voided_at                 :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  client_id                 :bigint           not null, indexed, indexed => [swap_id]
#  hotel_id                  :bigint           not null, indexed
#  swap_id                   :bigint           indexed => [client_id], indexed
#  user_id                   :bigint           not null, indexed
#  voided_by_id              :bigint           indexed
#
# Indexes
#
#  index_vouchers_on_client_id              (client_id)
#  index_vouchers_on_client_id_and_swap_id  (client_id,swap_id)
#  index_vouchers_on_hotel_id               (hotel_id)
#  index_vouchers_on_swap_id                (swap_id)
#  index_vouchers_on_user_id                (user_id)
#  index_vouchers_on_voided_by_id           (voided_by_id)
#
# Foreign Keys
#
#  fk_rails_1a4d6b99f0  (swap_id => swaps.id)
#  fk_rails_1ea81e504c  (hotel_id => hotels.id)
#  fk_rails_35b9b0ce9d  (client_id => clients.id)
#  fk_rails_3e6ca7b204  (user_id => users.id)
#  fk_rails_8c1008a5cb  (voided_by_id => users.id)
#
class Voucher < ApplicationRecord
  has_logidze
  belongs_to :client
  belongs_to :issuer, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voided_by, class_name: 'User', optional: true
  belongs_to :hotel
  belongs_to :swap

  validates :check_in, :check_out, presence: true

  # client can have multiple vouchers, just not in the same hotel and swap period?
  # use case: client receives a voucher, gets flagged, needs to move to another hotel
  # validates :client_id, uniqueness: { scope: :swap_id }

  # validates :client_id, uniqueness: { scope: [:swap_id, :hotel_id] } <-- can we do this?
  # validates :one_active_voucher_per_swap_per_hotel <-- or a fancy validation method?

  validate :dates_must_be_today_or_later_when_issued, on: :create
  validate :order_of_dates, :dates_must_fall_within_swap_period

  # num_adults_in_household
  # num_children_in_household

  after_create :save_number

  scope :active, -> { where(voided_at: nil) }
  scope :voided, -> { where.not(voided_at: nil) }

  LOW_SUPPLY_THRESHOLD = 10

  def void!(user)
    update(voided_at: Time.current, voided_by: user)
  end

  def voided?
    voided_at.present?
  end

  def duration
    ((check_out - check_in) + 1).to_i
  end

  def nights
    duration - 1
  end

  def nights_remaining
    [(check_out - Date.current).to_i, 0].max
  end

  def extend!(nights)
    nights = nights.to_i
    raise :cannot_extend_voucher_by_negative_number_of_days if nights.negative?

    self.check_out = check_out + nights
    save!
  end

  def guests
    Client.where(id: guest_ids)
  end

  private

  def save_number
    self.number = '%.7d' % id
    save!
  end

  def order_of_dates
    if check_out && (check_out < check_in)
      errors.add(
        :dates,
        "check_out: #{check_out} must be same day or later than check_in: #{check_in}",
      )
    end
  end

  def dates_must_be_today_or_later_when_issued
    if check_in.blank?
      return errors.add(:check_in, 'Must provide a check in date')
    end

    if check_out.blank?
      return errors.add(:check_out, 'Must provide a check out date')
    end

    if check_in < Date.current
      errors.add(:check_in, "Can't issue backdated voucher dates")
    end

    if check_out < Date.current
      errors.add(:check_out, "Can't issue backdated voucher dates")
    end
  end

  def dates_must_fall_within_swap_period
    if swap && !(check_in.in? swap.stay_period)
      errors.add(
        :check_in,
        "check_in (#{check_in}) does not fall within swap period: #{swap.stay_period}",
      )
    end

    if swap && !(check_out.in? swap.stay_period)
      errors.add(
        :check_out,
        "check_out (#{check_out}) does not fall within swap period: #{swap.stay_period}",
      )
    end
  end
end
