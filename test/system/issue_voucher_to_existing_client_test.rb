require "application_system_test_case"

class IssueVoucherToExistingClientTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  # search client -> client page -> voucher form -> voucher created
  test "happy path" do
    user = create(:user)
    sign_in user
    motel = create(:motel)
    swap = create(:swap, :current)
    create(:availability, motel: motel, swap: swap, vacant: 1)
    client = create(:client)

    # searching for client
    visit clients_path
    fill_in "search-input", with: client.last_name
    click_on "search-btn"
    # client found
    assert_text client.last_name


    # client page
    click_on client.last_name
    assert_current_path client_path(client)

    assert_text /1 vouchers remaining today/i
    click_on "hotel voucher"

    # voucher form
    assert_current_path new_voucher_path(client_id: client.id)
    # prefilled
    assert_text client.name
    select "#{motel.name} (1)", from: "Hotel (vouchers remaining)"

    click_on "Create"

    # done!
    assert_current_path voucher_created_path(Voucher.last)
    assert_text /voucher created/
    assert_text client.name
  end
end
