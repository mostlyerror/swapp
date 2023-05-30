class TestMailer < ApplicationMailer
  def test(user)
    # caller must call .deliver on this mail object to actually perform the delivery!
    mail(
      to: user.email,
      subject: 'Thanks for signing up for our amazing (sw)app',
    )
  end
end
