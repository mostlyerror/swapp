require 'test_helper'

class TestMailerTest < ActionMailer::TestCase
  test "send_test" do
    mail = TestMailer.send_test
    assert_equal "Send test", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
