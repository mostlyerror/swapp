class VoucherMailer < ApplicationMailer
    def voucher_email
        @voucher = params[:voucher]
        mail(to: @voucher.client.email, subject: 'Voucher Confirmation')
    end
end