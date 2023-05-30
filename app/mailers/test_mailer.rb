class TestMailer < ApplicationMailer
  def test
    mail(to: "benjamintpoon@gmail.com", subject: "Test SWAP Mail")
  end
end
