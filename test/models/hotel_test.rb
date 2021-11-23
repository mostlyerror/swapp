# == Schema Information
# Schema version: 20211123040336
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  address      :jsonb
#  deleted_at   :datetime
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class HotelTest < ActiveSupport::TestCase
  test "soft delete only sets deleted_at, doesn't destroy the record" do
    hotel = create(:hotel)
    assert hotel.deleted_at.blank?
    hotel.destroy
    refute hotel.reload.deleted_at.blank?
  end
end
