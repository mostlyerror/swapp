class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel
  belongs_to :swap_period

  validate :dates_must_be_in_swap_period

  after_create :save_number
  def save_number
    self.number = "AH%.5d" % id
    save!
  end

  def dates_must_be_in_swap_period
    true
  end
end
