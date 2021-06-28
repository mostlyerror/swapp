require "application_system_test_case"

class IntakesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user
  end

  test "filling out intake form and seeing voucher form" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    create(:availability, hotel: hotel, swap: swap, vacant: 1)
    client = build_stubbed(:client, :veteran)
    intake = build_stubbed(:intake, client: client)

    visit new_intake_path

    fill_in(Intake::FIRST_NAME.text, with: client.first_name)
    fill_in(Intake::LAST_NAME.text, with: client.last_name)
    fill_in(Intake::DATE_OF_BIRTH.text, with: client.date_of_birth)
    select(client.gender, from: Intake::GENDER.text)
    client.race.each { |r| check(r, allow_label_click: true) }
    select(client.ethnicity, from: Intake::ETHNICITY.text)

    click_on("+ add family member")
    within("#family-member-form") do
      fill_in("first_name", with: FFaker::Name.first_name)
      fill_in("last_name", with: FFaker::Name.last_name)
      fill_in("relationship", with: random_relationship)
      fill_in("date_of_birth", with: FFaker::Time.date)
      check(Client::RACE.sample)
      select(Client::GENDER.sample, from: "family-member-form-gender")
      choose("family-member-form-ethnicity-#{%w(yes no).sample}")
      choose("family-member-form-veteran-#{%w(yes no).sample}")
      choose("family-member-form-disabling-condition-#{%w(yes no).sample}")
      click_on("Save Family Member")
    end

    toggle(Intake::HOUSEHOLD_TANF.key, intake.household_tanf)
    fill_in(Intake::HOMELESSNESS_DATE_BEGAN.text, with: intake.homelessness_date_began)
    if !intake.have_you_ever_experienced_homelessness_before
      toggle(Intake::HOMELESSNESS_FIRST_TIME.key, false)
    end
    choose(intake.homelessness_how_long_this_time)
    select(intake.homelessness_episodes_last_three_years, from: Intake::HOMELESSNESS_EPISODES_LAST_THREE_YEARS.text)
    select(intake.homelessness_total_last_three_years, from: Intake::HOMELESSNESS_TOTAL_LAST_THREE_YEARS.text)
    fill_in Intake::LAST_PERMANENT_RESIDENCE_COUNTY.text, with: intake.last_permanent_residence_county
    select(intake.health_insurance, from: Intake::HEALTH_INSURANCE.text)
    select(intake.are_you_working, from: Intake::ARE_YOU_WORKING.text)
    intake.non_cash_benefits.each { |b| check(b, allow_label_click: true) }
    toggle(Intake::INCOME_SOURCE.key, intake.income_source_any)

    if intake.income_source_any
      Intake::INCOME_SOURCE.sub_choices.keys.each { |s| fill_in s, with: intake.public_send(s) }
    end

    if client.veteran
      toggle(Intake::VETERAN.key, client.veteran)
      choose(client.veteran_military_branch)
      fill_in Intake::VETERAN_SEPARATION_YEAR.text, with: client.veteran_separation_year
      choose(client.veteran_discharge_status)
    end

    toggle(Intake::ACTIVE_DUTY.key, intake.active_duty)
    select intake.substance_misuse, from: Intake::SUBSTANCE_MISUSE.text
    toggle(Intake::CHRONIC_HEALTH_CONDITION.key, intake.chronic_health_condition)
    toggle(Intake::MENTAL_HEALTH_DISABILITY.key, intake.mental_health_disability)
    toggle(Intake::PHYSICAL_DISABILITY.key, intake.physical_disability)
    toggle(Intake::DEVELOPMENTAL_DISABILITY.key, intake.developmental_disability)
    toggle(Intake::FLEEING_DOMESTIC_VIOLENCE.key, intake.fleeing_domestic_violence)

    click_on "Submit"

    assert_text /create voucher/i

    new_client = Client.last
    assert new_client.intakes.size == 1
    new_intake = new_client.intakes.last

    # email and phone number collected in voucher form, not intake form
    ignore_attrs = %w( id user_id client_id email phone_number family_members created_at updated_at )
    assert_equal client.attributes.except(*ignore_attrs), new_client.attributes.except(*ignore_attrs)
    assert_equal intake.attributes.except(*ignore_attrs), new_intake.attributes.except(*ignore_attrs)
  end

  def toggle(key, val)
    within("##{key}") do
      val && click_on("No")
    end
  end

  def random_relationship
    %w(spouse wife husband mom dad mother father parent uncle aunt grandfather grandmother brother sister cousin nephew niece).sample
  end
end