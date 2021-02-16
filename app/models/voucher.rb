class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel

  after_create :save_number

  def save_number
    self.number = "AH%.5d" % id
    save!
  end
end
