# == Schema Information
# Schema version: 20211104062639
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  active       :boolean          default(TRUE)
#  address      :json
#  log_data     :jsonb
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'test_helper'

class HotelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
