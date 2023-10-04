class ShortIntake < ApplicationRecord
  belongs_to :swap, optional: true
  belongs_to :client
  accepts_nested_attributes_for :client
  belongs_to :user

  # normally has_one, but we might need to reissue voucher with the same short intake
  has_many :vouchers

  auto_strip_attributes :where_did_you_sleep_last_night,
                        :what_city_did_you_sleep_in_last_night,
                        :why_not_shelter,
                        :pets,
                        :vehicle,
                        :identification,
                        :household_composition_changed,
                        :bus_pass,
                        :king_soopers_card,
                        :waiver_and_participant_agreement,
                        :ada_room_required
end
