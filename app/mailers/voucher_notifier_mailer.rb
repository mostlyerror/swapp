class VoucherNotifierMailer < ApplicationMailer
    # default :from 'any_from_address@example.com'

    def send_digital_voucher
        mail( :to => 'vagarioustoast@gmail.com',
        :subject => 'Welcome')
        end
end
