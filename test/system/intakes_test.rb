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

    fill_in Intake::FIRST_NAME.text, with: client.first_name
    fill_in Intake::LAST_NAME.text, with: client.last_name
    fill_in Intake::DATE_OF_BIRTH.text, with: client.date_of_birth
    select client.gender, from: Intake::GENDER.text
    client.race.each { |r| check(r) }
    select client.ethnicity, from: Intake::ETHNICITY.text

    toggle(intake.homelessness_first_time)

    fill_in Intake::HOMELESSNESS_DATE_BEGAN.text, with: (Date.current - 1.year)

    choose Intake::HOMELESSNESS_HOW_LONG_THIS_TIME.choices.sample

    select Intake::HOMELESSNESS_EPISODES_LAST_THREE_YEARS.choices.sample,

      from: Intake::HOMELESSNESS_EPISODES_LAST_THREE_YEARS.text
    select Intake::HOMELESSNESS_TOTAL_LAST_THREE_YEARS.choices.sample,
      from: Intake::HOMELESSNESS_TOTAL_LAST_THREE_YEARS.text

    select Intake::HEALTH_INSURANCE.choices.sample,
      from: Intake::HEALTH_INSURANCE.text

    select Intake::ARE_YOU_WORKING.choices.sample,
      from: Intake::ARE_YOU_WORKING.text

    non_cash_benefits_choices = Intake::NON_CASH_BENEFITS.choices
    non_cash_benefits = non_cash_benefits_choices.size.times.map { non_cash_benefits_choices.sample }
    non_cash_benefits.each { |b| check b }
    
    if rand(2) == 0
      find(id: "intake_income_source_any_no").click
    else
      find(id: "intake_income_source_any_yes").click
      income_source_choices = Intake::INCOME_SOURCE.sub_choices.values
      income_sources = income_source_choices.size.times.map { income_source_choices.sample }
      income_sources.each { |s| fill_in s, with: '100' }
    end

    if rand(2) == 0
      find(id: "intake_client_attributes_veteran_no").click
    else
      find(id: "intake_client_attributes_veteran_yes").click
      find(id: "intake_client_attributes_veteran_military_branch_army").choose
      fill_in "Year separated", with: "1979"
      find(id: "intake_client_attributes_veteran_discharge_status_honorable").choose
    end

    if rand(2) == 0
      find(id: "intake_active_duty_no").click
    else
      find(id: "intake_active_duty_yes").click
    end

    select Intake::SUBSTANCE_MISUSE.choices.sample, from: Intake::SUBSTANCE_MISUSE.text

    if rand(2) == 0
      find(id: "intake_chronic_health_condition_no").click
    else
      find(id: "intake_chronic_health_condition_yes").click
    end

    if rand(2) == 0
      find(id: "intake_mental_health_disability_no").click
    else
      find(id: "intake_mental_health_disability_yes").click
    end

    if rand(2) == 0
      find(id: "intake_mental_health_disability_no").click
    else
      find(id: "intake_mental_health_disability_yes").click
    end

    if rand(2) == 0
      find(id: "intake_mental_health_disability_no").click
    else
      find(id: "intake_mental_health_disability_yes").click
    end

    if rand(2) == 0
      find(id: "intake_physical_disability_no").click
    else
      find(id: "intake_physical_disability_yes").click
    end

    if rand(2) == 0
      find(id: "intake_physical_disability_no").click
    else
      find(id: "intake_physical_disability_yes").click
    end

    if rand(2) == 0
      find(id: "intake_developmental_disability_no").click
    else
      find(id: "intake_developmental_disability_yes").click
    end

    if rand(2) == 0
      find(id: "intake_fleeing_domestic_violence_no").click
    else
      find(id: "intake_fleeing_domestic_violence_yes").click
    end

    fill_in Intake::LAST_PERMANENT_RESIDENCE_COUNTY.text, with: "Adams"

    click_on "Submit"

    # assert_current_path new_voucher_path(client_id: Client.last.id, intake_id: Intake.last.id)
    assert_text /create a voucher/i

    # # assert values are saved
    # new_client = Client.last
    # assert_equal client.first_name, new_client.first_name
    # assert_equal client.last_name, new_client.last_name
    # assert_equal client.gender, new_client.gender
    # assert_equal client.race, new_client.race
    # assert_equal client.ethnicity, new_client.ethnicity
    # assert new_client.intakes.size == 1

    # assert new_client.veteran
    # assert new_client.veteran_military_branch = "Army"
    # assert new_client.veteran_separation_year = "1979"
    # assert new_client.veteran_discharge_status = "Honorable"

    # new_intake = new_client.intakes.last
    # assert new_intake.active_duty
    # assert new_intake.substance_misuse = "Alcohol and Drugs"
    # assert new_intake.chronic_health_condition
    # assert new_intake.mental_health_disability
    # assert new_intake.physical_disability
    # assert new_intake.developmental_disability
    # assert new_intake.fleeing_domestic_violence
  end

  def toggle(key, bool, &block)
    id = "#{key}_#{bool.true? ? 'yes' : 'no'}"
    find(id: id).click
    block.call if block_given?
  end
end
