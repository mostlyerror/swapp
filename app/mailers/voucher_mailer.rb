class VoucherMailer < ApplicationMailer
  def voucher(email)
    mail(to: 'example@email.com', subject: 'email subject', body: 'email body')
  end
end
