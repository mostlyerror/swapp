FactoryBot.define do
  factory :short_intake do
    client
    user
    where_did_you_sleep_last_night { Intake::SLEEP_LAST_NIGHT.choices.sample }
    what_city_did_you_sleep_in_last_night { 'Thornton' }
    why_not_shelter { Intake::WHY_NOT_SHELTER.choices.sample }
    bus_pass { [true, false].sample }
    king_soopers_card { [true, false].sample }
    family_members { "{}" }
    household_composition_changed { false }
  end
end