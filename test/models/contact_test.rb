require "test_helper"

class ContactTest < ActiveSupport::TestCase
  test "contact can have 0 to many hotels" do
    c = create(:contact)
  end
end
