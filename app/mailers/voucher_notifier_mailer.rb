class VoucherNotifierMailer < ApplicationMailer
    default from: 'example@example.com'

    def send_digital_voucher

        # @client = client
        mail(to: 'vagarioustoast@gmail.com', subject: 'Hello')
    end
end
