require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "searching for a client" do
    user = create(:user)
    sign_in user

    client = create(:client)
    visit root_path
    assert_text /start/i

    fill_in id: 'search-input', with: client.last_name
    click_on id: 'search-btn'

    assert_text client.last_name
  end
end