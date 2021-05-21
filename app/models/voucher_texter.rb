class VoucherTexter
  def initialize(voucher, sid, token, phone_number)
    @voucher = Voucher.find(params[:id])
    @twilio_number = phone_number
  end

  def self.send_sms(voucher, sid, token)
    @voucher = Voucher.find(voucher.id)
    @client = Twilio::REST::Client.new(sid, token)
    body = "Thanks, #{@voucher.client.name}! Your voucher for #{@voucher.hotel.name} is confirmed!\n\nVoucher #: #{@voucher.number}\n\n#{@voucher.hotel.name} is expecting you from #{@voucher.check_in} to #{@voucher.check_out}.\n\nAddress:\n\n#{@voucher.hotel.street_address}\n#{@voucher.hotel.address_second}\n#{@voucher.hotel.phone}"

    @client.messages.create(
      from: ENV["TWILIO_NUMBER"],
      to: @voucher.client.phone_number,
      body: body
    )
  end

end