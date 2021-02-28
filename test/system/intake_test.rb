require "application_system_test_case"

class IntakeTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user
  end

  test "filling out intake form and seeing created voucher" do
    motel = create(:motel)
    swap = create(:swap, :current)
    create(:availability, motel: motel, swap: swap, vacant: 1)
    client = create(:client)

    visit new_intake_path
    assert_text /intake/i
    assert_text /1 vouchers remaining today/i


    fill_in "First Name", with: client.first_name
    fill_in "Last Name", with: client.last_name
    fill_in "Date of birth", with: client.date_of_birth
    select client.gender, from: "Gender"
    find(id: "intake_client_attributes_race_american_indian_or_alaskan_native").set(true)
    find(id: "intake_client_attributes_race_asian").set(true)
    select client.ethnicity, from: "Hispanic or Latino?"

    find(id: "intake_survey[homelessness_first_time]_false").click
    fill_in "intake_survey[homelessness_how_long_this_time]", with: "2 years"
    find(id: "intake_survey[homelessness_episodes_last_three_years]_fewer_than_4_times").click
    fill_in "intake_survey[homelessness_episodes_how_long]", with: "2 weeks"
    fill_in "intake_survey[how_long_living_in_this_community]", with: "20 years"
    find(id: "intake_survey[where_did_you_sleep_last_night]_on_the_streets_or_in_a_tent").click
    find(id: "intake_survey[why_not_shelter]_safety_concerns").click
    select "No", from: "intake_survey[are_you_working]"

    # skip yes/no's with defaults
    # ...

    fill_in "intake_survey[num_adults_household]", with: "1"
    fill_in "intake_survey[num_children_household]", with: "0"
    fill_in "intake_survey[last_permanent_residence_city_and_state]", with: "Brighton, CO"
    fill_in "intake_survey[last_permanent_residence_county]", with: "Adams"

    select "#{motel.name} (1)", from: "intake_survey[motel_id]"
    fill_in "intake_client_attributes_phone_number", with: client.phone_number
    fill_in "intake_client_attributes_email", with: client.email

    click_on "Submit"

    assert_current_path voucher_created_path(Voucher.last)
    assert_text /voucher created/i
    assert_text client.name
  end
end
