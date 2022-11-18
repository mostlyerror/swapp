ActionMailer::Base.smtp_settings = {
  domain: ENV['STAGING'] == 'true' ? 'swapp-staging-1.herokuapp.com' : 'swapp-1.herokuapp.com',
  address: 'smtp.sendgrid.net',
  port: 587,
  authentication: :plain,
  user_name: 'apikey',
  password: ENV['SENDGRID_API_KEY']
}