class VoucherNotifierMailer < ApplicationMailer
    default :from 'any_from_address@example.com'

    def send_digital_voucher(voucher)
        @client = client
        @voucher = voucher
        mail( :to => @client.email,
        :subject => `Your voucher for #{Date.current}`)
        end
end
