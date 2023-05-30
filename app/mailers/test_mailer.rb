class TestMailer < ApplicationMailer
  def test
    mail(to: "benjamintpoon@gmail.com", subject: "Test SWAP Mail", body: "hey there")
  end
end
