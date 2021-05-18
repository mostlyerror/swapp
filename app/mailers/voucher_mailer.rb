class VoucherMailer < ApplicationMailer
    def voucher_email
        @voucher = params[:voucher]
        mail(to: @voucher.client.email, subject: 'SWAP Voucher Confirmation')
    end
end