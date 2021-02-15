class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :motel
end
