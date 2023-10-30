class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :issuer, class_name: 'User', foreign_key: 'user_id'
  belongs_to :voided_by, class_name: 'User', optional: true
  belongs_to :hotel
  belongs_to :swap
  belongs_to :short_intake

  validates :check_in, :check_out, presence: true
  validate :one_active_voucher_per_client_per_swap
  validate :dates_must_be_today_or_later_when_issued, on: :create
  validate :order_of_dates, :dates_must_fall_within_swap_period

  delegate :ada_room_required, to: :short_intake, allow_nil: true

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

  def one_active_voucher_per_client_per_swap
    return if voided?

    if Voucher
         .active
         .where(swap_id: swap_id, client_id: client_id)
         .where.not(id: id)
         .present?
      errors.add(:client, 'max one active voucher per client per swap')
    end
  end
end
