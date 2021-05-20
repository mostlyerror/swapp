<<<<<<< HEAD
# require "application_system_test_case"

# class VouchersTest < ApplicationSystemTestCase
#   include Devise::Test::IntegrationHelpers

#   setup do
#     user = create(:user)
#     sign_in user
#   end

#   test "issuing a voucher to existing client" do

#     hotel = create(:hotel)
#     swap = create(:swap, :current)
#     create(:availability, hotel: hotel, swap: swap, vacant: 1)

#     client = create(:client)
#     visit new_voucher_path(client_id: client.id)

#     assert_selector "[value='#{Date.current.strftime("%Y-%m-%d")}']"

#     select hotel.name, from: "Hotel"
#     click_on "Create"

#     # voucher ID saved after creation
#     assert_text "AH%.5d" % Voucher.last.id
#     assert_text client.name
#   end
# end
=======
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
    assert_text /create a voucher/i
    assert_text /1 vouchers remaining today/i

    choose(Intake::SLEEP_LAST_NIGHT.choices.sample)
    fill_in(Intake::CITY_LAST_NIGHT.text, with: "thornton")
    select("#{hotel.name} (1)", from: "Hotel (vouchers remaining)")
    check("voucher_short_intake_why_not_shelter_no_room")
    toggle("voucher", "guests", true)

    # guest section is empty
    assert_no_text guest.first_name
    assert_no_text guest.date_of_birth.to_s
    assert_no_text /name/i
    assert_no_text /dob/i

    # guest appears in autocomplete
    # fill_in('guest_autocomplete', with: guest.first_name)
    find("#guest_autocomplete").send_keys(guest.first_name)
    assert_text guest.first_name
    assert_text guest.date_of_birth.to_s

    # click on match, guest added to guest list
    find("#add_guest_#{guest.id}").click
    assert_text /name/i
    assert_text /dob/i
    assert_text guest.first_name
    assert_text guest.date_of_birth.to_s

    fill_in Intake::PHONE_NUMBER.text, with: client.phone_number
    fill_in Intake::EMAIL.text, with: client.email
    find("#voucher_short_intake_bus_pass_yes").click
    find("#voucher_short_intake_king_soopers_card_yes").click

    click_on "Create"

    assert_text /created/i
    assert_text Voucher.last.number
    assert_text client.name
    assert_text /guests/i
    assert_text guest.name
  end

  def toggle(form_prefix, key, bool, &block)
    id = "#{form_prefix}_#{key}_#{bool && 'yes' || 'no'}"
    find(id: id).click
    block.call if block_given?
  end
end
>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
