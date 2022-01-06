require "test_helper"

class ClientsTest < ActiveSupport::TestCase
  setup do
    @hotel = create(:hotel)
  end

  test "#ban_at! returns created red flag at hotel" do
    client = create(:client)
    assert_not client.banned?
    assert_not client.partial_ban?
    assert client.no_flags?

    client.ban_at!(@hotel)
    assert_not client.banned?
    assert client.partial_ban?
    assert_not client.no_flags?
    assert_equal client.red_flags.count, 1

    client.ban!
    assert client.banned?
    assert_not client.partial_ban?
    assert_not client.no_flags?
    assert_equal client.red_flags.count, 1
  end
end
