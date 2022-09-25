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
module HotelsHelper
end
