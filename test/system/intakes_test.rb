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
    intake = build_stubbed(:intake, client: client)

    visit new_intake_path
    assert_text /intake/i
    assert_text /1 vouchers remaining today/i

    fill_in(Intake::FIRST_NAME.text, with: client.first_name)
    fill_in(Intake::LAST_NAME.text, with: client.last_name)
    fill_in(Intake::DATE_OF_BIRTH.text, with: client.date_of_birth)
    select(client.gender, from: Intake::GENDER.text)
    client.race.each { |r| check(r) }
    select(client.ethnicity, from: Intake::ETHNICITY.text)
    toggle("intake", Intake::HOMELESSNESS_FIRST_TIME.key, intake.homelessness_first_time)
    fill_in(Intake::HOMELESSNESS_DATE_BEGAN.text, with: intake.homelessness_date_began)
    choose(intake.homelessness_how_long_this_time)
    select(intake.homelessness_episodes_last_three_years, from: Intake::HOMELESSNESS_EPISODES_LAST_THREE_YEARS.text)
    select(intake.homelessness_total_last_three_years, from: Intake::HOMELESSNESS_TOTAL_LAST_THREE_YEARS.text)
    select(intake.health_insurance, from: Intake::HEALTH_INSURANCE.text)
    select(intake.are_you_working, from: Intake::ARE_YOU_WORKING.text)
    intake.non_cash_benefits.each { |b| check b }

    toggle("intake", Intake::INCOME_SOURCE.key, intake.income_source_any)
    if intake.income_source_any
      Intake::INCOME_SOURCE.sub_choices.keys.each { |s| fill_in s, with: intake.public_send(s) }
    end

    toggle("intake_client_attributes", Intake::VETERAN.key, client.veteran)
    if client.veteran
      choose(client.veteran_military_branch)
      fill_in Intake::VETERAN_SEPARATION_YEAR.text, with: client.veteran_separation_year
      choose(client.veteran_discharge_status)
    end

    toggle("intake", Intake::ACTIVE_DUTY.key, intake.active_duty)
    select intake.substance_misuse, from: Intake::SUBSTANCE_MISUSE.text
    toggle("intake", Intake::CHRONIC_HEALTH_CONDITION.key, intake.chronic_health_condition)
    toggle("intake", Intake::MENTAL_HEALTH_DISABILITY.key, intake.mental_health_disability)
    toggle("intake", Intake::PHYSICAL_DISABILITY.key, intake.physical_disability)
    toggle("intake", Intake::DEVELOPMENTAL_DISABILITY.key, intake.developmental_disability)
    toggle("intake", Intake::FLEEING_DOMESTIC_VIOLENCE.key, intake.fleeing_domestic_violence)
    fill_in Intake::LAST_PERMANENT_RESIDENCE_COUNTY.text, with: intake.last_permanent_residence_county

    click_on "Submit"

    assert_text /create a voucher/i

    new_client = Client.last
    assert_equal client.first_name, new_client.first_name
    assert_equal client.last_name, new_client.last_name
    assert_equal client.gender, new_client.gender
    assert_equal client.race, new_client.race
    assert_equal client.ethnicity, new_client.ethnicity
    assert_equal client.veteran, new_client.veteran
    assert_equal client.veteran_military_branch, new_client.veteran_military_branch
    assert_equal client.veteran_separation_year, new_client.veteran_separation_year
    assert_equal client.veteran_discharge_status, new_client.veteran_discharge_status

    assert new_client.intakes.size == 1
    new_intake = new_client.intakes.last
    assert_equal intake.substance_misuse, new_intake.substance_misuse
    assert_equal intake.active_duty, new_intake.active_duty
    assert_equal intake.chronic_health_condition, new_intake.chronic_health_condition
    assert_equal intake.mental_health_disability, new_intake.mental_health_disability
    assert_equal intake.physical_disability, new_intake.physical_disability
    assert_equal intake.developmental_disability, new_intake.developmental_disability
    assert_equal intake.fleeing_domestic_violence, new_intake.fleeing_domestic_violence
    assert_equal intake.last_permanent_residence_county, new_intake.last_permanent_residence_county
  end

  def toggle(form_prefix, key, bool, &block)
    id = "#{form_prefix}_#{key}_#{bool && 'yes' || 'no'}"
    find(id: id).click
    block.call if block_given?
  end
end
