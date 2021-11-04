# == Schema Information
# Schema version: 20211103053452
#
# Table name: short_intakes
#
#  id                                    :bigint           not null, primary key
#  bus_pass                              :boolean
#  household_composition_changed         :boolean
#  king_soopers_card                     :boolean
#  what_city_did_you_sleep_in_last_night :string
#  where_did_you_sleep_last_night        :string
#  why_not_shelter                       :string           default([]), is an Array
#  created_at                            :datetime         not null
#  updated_at                            :datetime         not null
#  client_id                             :bigint           not null, indexed
#  user_id                               :bigint           not null, indexed
#
# Indexes
#
#  index_short_intakes_on_client_id  (client_id)
#  index_short_intakes_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_89b2ca1ad8  (client_id => clients.id)
#  fk_rails_9bcdbad11d  (user_id => users.id)
#
FactoryBot.define do
  factory :short_intake do
    client
    user
    where_did_you_sleep_last_night { Intake::SLEEP_LAST_NIGHT.choices.sample }
    what_city_did_you_sleep_in_last_night { 'Thornton' }
    why_not_shelter { Intake::WHY_NOT_SHELTER.choices.sample }
    bus_pass { [true, false].sample }
    king_soopers_card { [true, false].sample }
    household_composition_changed { false }
  end
end
