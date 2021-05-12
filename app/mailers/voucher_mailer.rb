class VoucherMailer < ApplicationMailer
  def voucher(email)
    mail(to: email, subject: 'email subject', body: 'email body')
  end
end
