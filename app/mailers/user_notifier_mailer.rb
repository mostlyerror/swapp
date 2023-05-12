class UserNotifierMailer < ApplicationMailer
  def send_user_update_email(user)
    @user = user
    mail(
      to: 'benjamintpoon@gmail.com',
      subject: 'Wow, an email came through from SWAPP',
      body: 'This is the body of the email',
    )
  end
end
