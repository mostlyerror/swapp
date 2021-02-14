class Voucher < ApplicationRecord
  belongs_to :client
  belongs_to :intake
  belongs_to :motel
end
