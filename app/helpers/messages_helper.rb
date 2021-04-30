module MessagesHelper

    def parse_sms(sms)
         
        body = sms[:Body]&.strip&.upcase
        from = sms[:From]

        case body

        when "SWAP"
            hotels = Hotel.all.pluck(:name)
            vouchers_today = RoomSupply.vouchers_remaining_today(Swap.current)
            vacancies = vouchers_today.map do |(hotel_id, vouchers)|
                # {name: hotels[hotel_id], vouchers: vouchers }]
                puts "HOTEL: #{hotels[hotel_id]}, VOUCHERS: #{vouchers}"
            end


            return "#{vacancies}"
        
        when "ACTIVATE"
            return "You messaged #{body}"
        else
            return "Unknown command. The available commands are SWAP and ACTIVATE. Please try again."
    end
end
end
