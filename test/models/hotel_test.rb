# == Schema Information
# Schema version: 20220924214711
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  address      :jsonb
#  deleted_at   :datetime
#  log_data     :jsonb
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require "test_helper"

class HotelTest < ActiveSupport::TestCase
  test ".active does not include inactive hotels" do
    create(:hotel)
    create(:hotel, active: false)
    active_hotels = Hotel.active
    assert_equal active_hotels.count, 1
  end

  test "soft delete only sets deleted_at, doesn't destroy the record" do
    hotel = create(:hotel)
    assert hotel.deleted_at.blank?
    hotel.destroy
    assert_not hotel.reload.deleted_at.blank?
  end

  test "soft delete updates timestamps" do
    hotel = create(:hotel)
    last_updated = hotel.updated_at
    hotel.destroy
    assert_not_equal hotel.reload.updated_at, last_updated
  end
end
