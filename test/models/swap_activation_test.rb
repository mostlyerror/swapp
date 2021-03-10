require 'test_helper'

class SwapActivationTest < ActiveSupport::TestCase
  test "states" do
    swap = build_stubbed :swap, :tomorrow
    assert swap.inactive?
    refute swap.active?
    assert swap.may_activate?
    refute swap.may_deactivate?

    assert_enqueued_emails 0
    assert_not_raises { swap.activate! }
    assert_enqueued_email_with SwapMailer, :activated, args: []
    assert_enqueued_emails 1

    refute swap.inactive?
    assert swap.active?
    refute swap.may_activate?
    assert swap.may_deactivate?

    assert_enqueued_emails 0
    assert_not_raises { swap.deactivate! }
    assert_enqueued_email_with SwapMailer, :activated, args: []
    assert_enqueued_emails 1
  end
end
