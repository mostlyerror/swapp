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

    select motel.name, from: "Hotel"
    click_on "Create"

    assert_text /Hotel voucher created!/i
  end
end