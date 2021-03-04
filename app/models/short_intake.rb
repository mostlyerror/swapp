class ShortIntake < ApplicationRecord
  belongs_to :client
  accepts_nested_attributes_for :client
  belongs_to :user

  auto_strip_attributes :where_did_you_sleep_last_night,
      :what_city_did_you_sleep_in_last_night,
      :why_not_shelter,
      :bus_pass,
      :king_soopers_card

end
