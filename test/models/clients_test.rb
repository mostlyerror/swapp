require 'test_helper'

class ClientsTest < ActiveSupport::TestCase
  setup do
    @hotel = create(:hotel)
  end

  test "#ban_at! returns created red flag at hotel" do
    client = create(:client)
    refute client.banned?
    refute client.partial_ban?
    assert client.no_flags?

    client.ban_at!(@hotel)
    refute client.banned?
    assert client.partial_ban?
    refute client.no_flags?
    assert_equal client.red_flags.count, 1

    client.ban!
    assert client.banned?
    refute client.partial_ban?
    refute client.no_flags?
    assert_equal client.red_flags.count, 1
  end
end
