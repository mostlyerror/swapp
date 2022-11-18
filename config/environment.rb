# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# maybe put this in its own file, config/initializers/smtp.rb
#
#ActionMailer::Base.smtp_settings = {
#  address: 'smtp.sendgrid.net',
#  port: 587,
#  domain: '',
#  user_name: ENV['SENDGRID_USERNAME'],
#  password: ENV['SENDGRID_PASSWORD'],
#  authentication: :login,
#  enable_starttls_auto: true
#}
# 
#if you are using the API key
ActionMailer::Base.smtp_settings = {
  domain: 'swapp-1.herokuapp.com',
  address:        'smtp.sendgrid.net',
  port:            587,
  authentication: :plain,
  user_name:      'apikey',
  password:       ENV['SENDGRID_API_KEY']
}
