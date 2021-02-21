require "application_system_test_case"

class VouchersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "issuing a voucher to existing client" do
    user = create(:user)
    sign_in user

    motel = create(:motel)
    swap = create(:swap_period, :current)
    client = create(:client)
    visit new_voucher_path(client_id: client.id)

    assert_selector "[value='#{Date.current.strftime("%Y-%m-%d")}']"



    select motel.name, from: "Hotel"
    click_on "Create"

    # voucher ID saved after creation
    assert_text "AH%.5d" % Voucher.last.id
    assert_text client.name
  end
end