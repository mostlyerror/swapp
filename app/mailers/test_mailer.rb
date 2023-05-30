class TestMailer < ApplicationMailer
  default from: 'ben@orbital-mechanics.dev'

  # send a signup email to the user, pass in the user object that   contains the user's email address
  def test(user)
    mail(
      to: user.email,
      subject: 'Thanks for signing up for our amazing (sw)app',
    )
  end
end
