class HotlineResponse
    HOTLINE_PHONE_NUMBER = "(720) 523-6646"

    def initialize(body, from)
        @body = body
        @from = from
    end

    def response
        Twilio::TwiML::MessagingResponse.new do |r|
            r.message body: message
        end
    end

    private

    def message
        if !Swap.current
          return "Swap is not currently active. Please check your activation email for details or call #{HOTLINE_PHONE_NUMBER}." 
        end

        if @body == "SWAP"
          return "Today's Availability (#{todays_availability}" 
        end

        "Thank you for contacting the Swap hotline. The only available command is SWAP.\n\nPlease try again or call #{HOTLINE_PHONE_NUMBER}."
    end

    def todays_availability
        hotels = Hotel.all.pluck(:id, :name).to_h
        vouchers_today = RoomSupply.vouchers_remaining_today(Swap.current)
        vacancies = vouchers_today.map do |hotel_id, vouchers|
            "#{hotels[hotel_id]} - #{vouchers}\n"
        end

        "#{Date.current}):\n\n#{vacancies.join()}"

    end
end