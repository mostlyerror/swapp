Twilio.configure do |config|
    config.account_sid = Rails.application.credentials.twilio_sid
    config.auth_token = Rails.application.credentials.auth_token
end