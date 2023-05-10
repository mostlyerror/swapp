require 'application_system_test_case'

class ClientPageSmokeTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    user = create(:user)
    @client = create(:client)
    sign_in user
  end

  test 'client detail page loads successfully' do
    visit client_path(@client)

    assert_text(@client.first_name)
  end
end
