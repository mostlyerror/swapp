class VoucherTexter
  def initialize(voucher, sid, token, phone_number)
    @voucher = voucher
    @twilio_number = twilio_number
    @client = Twilio::REST::Client.new(sid, token)
  end

  def send_sms
    @client.messages.create(
      from: @twilio_number,
      to: @voucher.client.phone_number,
      body: body
    )
  end
  
  private

  def body
    "Thanks, #{@voucher.client.name}! Your voucher for #{@voucher.hotel.name} is confirmed!\n\nVoucher #: #{@voucher.number}\n\n#{@voucher.hotel.name} is expecting you from #{@voucher.check_in} to #{@voucher.check_out}.\n\nAddress:\n\n#{@voucher.hotel.street_address}\n#{@voucher.hotel.address_second}\n#{@voucher.hotel.phone}"
  end
end