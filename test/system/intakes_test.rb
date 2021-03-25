require "application_system_test_case"

class IntakesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user
  end

  test "filling out intake form and seeing created voucher" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    create(:availability, hotel: hotel, swap: swap, vacant: 1)
    client = build_stubbed(:client)

    visit new_intake_path
    assert_text /intake/i
    assert_text /1 vouchers remaining today/i

    fill_in "First Name", with: client.first_name
    fill_in "Last Name", with: client.last_name
    fill_in "Date of Birth", with: client.date_of_birth
    select client.gender, from: "Gender"
    client.race.each { |r| check(r) }
    select client.ethnicity, from: "Hispanic or Latino?"
    find(id: "intake_homelessness_first_time_yes").click
    fill_in "Approximate date homelessness first began", with: (Date.current - 1.year)
    choose "2 to 6 nights"
    select "2", from: "Number of episodes of homelessness in the past three years?"
    select "6", from: "Total number of months of homelessness in the past three years."
    select "Medicaid", from: "Are you covered by health insurance?"
    select "No", from: "Are you working?"
    check "SNAP (Food Stamps)"
    check "WIC"
    find(id: "intake_income_source_any_yes").click
    fill_in "SSDI (Disability)", with: "600"
    fill_in "VA Service Compensation", with: "800"
    find(id: "intake_client_attributes_veteran_yes").click
    find(id: "intake_client_attributes_veteran_military_branch_army").choose
    fill_in "Year separated", with: "1979"
    find(id: "intake_client_attributes_veteran_discharge_status_honorable").choose
    find(id: "intake_active_duty_yes").click
    select "Alcohol and Drugs", from: "Do you have any Substance Misuse Issues?"
    find(id: "intake_chronic_health_condition_yes").click
    find(id: "intake_mental_health_disability_yes").click
    find(id: "intake_physical_disability_yes").click
    find(id: "intake_developmental_disability_yes").click
    find(id: "intake_fleeing_domestic_violence_yes").click
    fill_in "In what county was your last permanent residence?", with: "Adams"
    click_on "Submit"

    # assert_current_path new_voucher_path(client_id: Client.last.id, intake_id: Intake.last.id)
    assert_text /create a voucher/i

    # # assert values are saved
    new_client = Client.last
    assert_equal client.first_name, new_client.first_name
    assert_equal client.last_name, new_client.last_name
    assert_equal client.gender, new_client.gender
    assert_equal client.race, new_client.race
    assert_equal client.ethnicity, new_client.ethnicity
    assert new_client.intakes.size == 1

    assert new_client.veteran
    assert new_client.veteran_military_branch = "Army"
    assert new_client.veteran_separation_year = "1979"
    assert new_client.veteran_discharge_status = "Honorable"
  end
end
