class ApplicationMailer < ActionMailer::Base
  # single sender verification
  # https://docs.sendgrid.com/ui/sending-email/sender-verification
  default from: "benjamintpoon@gmail.com"
  layout "mailer"
end
