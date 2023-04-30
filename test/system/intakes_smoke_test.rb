require "application_system_test_case"

class IntakesTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    sign_in user
  end

  test "new intake path loads successfully" do
    swap = create(:swap, :tomorrow)
    hotel = create(:hotel)
    create(:availability, hotel: hotel, swap: swap, vacant: 1)
    client = build_stubbed(:client, :veteran)
    intake = build_stubbed(:intake, client: client)

    visit new_intake_path

    assert_text(/client intake/i)
  end
end