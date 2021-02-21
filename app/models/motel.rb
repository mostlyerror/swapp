class Motel < ApplicationRecord
  has_many :availabilities

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end
end
