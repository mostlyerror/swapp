require "application_system_test_case"

class VouchersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    @user = create(:user)
    sign_in @user
  end

  test "filling out voucher form" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    create(:availability, hotel: hotel, swap: swap, vacant: 1)
    client = create(:client)
    intake = create(:intake, client: client, user: @user)
    guest = create(:client)

    visit new_voucher_path(client_id: client.id)
    assert_text(/create voucher/i)
    assert_text(/1 voucher/i)

    choose(Intake::SLEEP_LAST_NIGHT.choices.sample)
    fill_in(Intake::CITY_LAST_NIGHT.text, with: "thornton")
    select("#{hotel.name} (1)", from: "Hotel (number of vouchers left)")
    check("voucher_short_intake_why_not_shelter_no_room")

    # guest section is empty
    assert_no_text guest.first_name
    assert_no_text guest.date_of_birth.to_s
    assert_no_text(/name/i)
    assert_no_text(/dob/i)

    # guest appears in autocomplete
    # fill_in('guest_autocomplete', with: guest.first_name)
    find("#guest_autocomplete").send_keys(guest.first_name)
    assert_text guest.first_name
    assert_text guest.date_of_birth.to_s

    # click on match, guest added to guest list
    find("#add_guest_#{guest.id}").click
    assert_text(/name/i)
    assert_text(/dob/i)
    assert_text guest.first_name
    assert_text guest.date_of_birth.to_s

    fill_in Intake::PHONE_NUMBER.text, with: client.phone_number
    fill_in Intake::EMAIL.text, with: client.email
    toggle(Intake::BUS_PASS.key, true)
    toggle(Intake::KING_SOOPERS_CARD.key, true)

    click_on "Create"

    assert_text(/created/i)
    assert_text Voucher.last.number
    assert_text client.name
    assert_text(/guests/i)
    assert_text guest.name
  end

  def toggle(key, val)
    within("##{key}") do
      val && click_on("No")
    end
  end
end
