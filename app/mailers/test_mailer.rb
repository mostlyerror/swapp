class TestMailer < ApplicationMailer
  def test
    from = Email.new(email: 'ben@orbital-mechanics.dev')
    to = Email.new(email: 'benjamintpoon@gmail.com')
    subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    email = Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: email.to_json)
    # mail(to: "benjamintpoon@gmail.com", subject: "Test SWAP Mail", body: "hey there")
  end
end
