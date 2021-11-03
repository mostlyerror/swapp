# == Schema Information
# Schema version: 20211103053452
#
# Table name: hotels
#
#  id           :bigint           not null, primary key
#  address      :json
#  name         :string           not null
#  pet_friendly :boolean          default(FALSE)
#  phone        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
module HotelsHelper
end
