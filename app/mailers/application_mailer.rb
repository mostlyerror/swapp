class ApplicationMailer < ActionMailer::Base
  default from: 'ben@orbital-mechanics.dev' # verified sender configured within SendGrid
  layout 'mailer'
end
