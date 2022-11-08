class MessageMailer < ApplicationMailer
  def email
    @user = params[:user]
    @message = params[:message]
    mail(
      to: @user.email,
      subject: @message.subject,
      # from: ENV['FROM_EMAIL'],
      from: "benjamintpoon@gmail.com",
      custom_args: {
        user_id: @user.id
      }
    )
  end
end
