require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers
  setup do
    user = create(:user)
    sign_in user
  end

  test "searching for a client" do
    client = create(:client)
    visit root_path
    assert_text /client search/i

    fill_in id: 'search-input', with: client.last_name
    click_on id: 'search-btn'

    assert_text client.last_name
  end
end
