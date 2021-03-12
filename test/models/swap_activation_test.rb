require 'test_helper'

class SwapActivationTest < ActiveSupport::TestCase
  test "states" do
    swap = create :swap, :tomorrow
    assert swap.inactive?
    refute swap.active?
    assert swap.may_activate?
    refute swap.may_deactivate?

    # assert_enqueued_emails 0
    assert_nothing_raised { swap.activate! }
    # assert_enqueued_email_with SwapMailer, :activated, args: []
    # assert_enqueued_emails 1

    refute swap.inactive?
    assert swap.active?
    refute swap.may_activate?
    assert swap.may_deactivate?

    # assert_enqueued_emails 0
    assert_nothing_raised { swap.deactivate! }
    # assert_enqueued_email_with SwapMailer, :activated, args: []
    # assert_enqueued_emails 1
  end
end
