class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel
  belongs_to :swap_period

  validate :dates_must_be_today_or_later_when_issued, on: :create

  after_create :save_number

  def dates_must_be_today_or_later_when_issued
    if (check_in < Date.current) or (check_out < Date.current)
      errors.add(:backdated, "Can't issue backdated voucher dates")
    end
  end

  private 
    def save_number
      self.number = "AH%.5d" % id
      save!
    end
end
