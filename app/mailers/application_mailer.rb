class ApplicationMailer < ActionMailer::Base
  # default from: "bjohnson@codeforamerica.org"
  # verified sender identity on SendGrid
  default from: "benjamintpoon@gmail.com"
  layout "mailer"
end
