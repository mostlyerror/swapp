module MessagesHelper

    def parse_sms(sms)
         
        body = sms[:Body]&.strip&.upcase
        from = sms[:From]

        case body

        when "SWAP"
            hotels = Hotel.all.pluck(:id, :name)
            vouchers_today = RoomSupply.vouchers_remaining_today(Swap.current)
            vacancies = vouchers_today.each do |(hotel_id, vouchers)|
               hotels[hotel_id] += vouchers
            end

            return "#{vacancies}"
        
        when "ACTIVATE"
            return "You messaged #{body}"
        else
            return "Unknown command. The available commands are SWAP and ACTIVATE. Please try again."
    end
end
end
