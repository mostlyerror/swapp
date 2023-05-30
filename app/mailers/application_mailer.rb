require 'sendgrid-ruby'

class ApplicationMailer < ActionMailer::Base
  # default from: "bjohnson@codeforamerica.org"
  default from: "ben@orbital-mechanics.dev"
  layout "mailer"
end
