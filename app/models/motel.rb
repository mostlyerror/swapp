class Motel < ApplicationRecord
  has_many :availabilities

  validates_presence_of :name

  def street_address
    address['street']
  end

  def address_second
    "#{address['city']}, #{address['state']} #{address['zip']}"
  end
end
