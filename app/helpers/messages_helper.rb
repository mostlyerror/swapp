module MessagesHelper

    def parse_sms(sms)
        if Swap.current
            body = sms[:Body]&.strip&.upcase
            from = sms[:From]
            
            case body

            when "SWAP"
                hotels = Hotel.all.pluck(:name)
                vouchers_today = RoomSupply.vouchers_remaining_today(Swap.current)
                vacancies = vouchers_today.map do |(hotel_id, vouchers)|
                    "#{hotels[hotel_id]} - #{vouchers}\n"
                end

                return "Today's Availability (#{Date.current}):\n\n#{vacancies.join()}" 

            when "ACTIVATE"
                return "You messaged #{body}"
            else
                return "Unknown command. The available commands are SWAP and ACTIVATE. Please try again."
            end
        else
            return "Swap is not currently active. Please check your activation email for details."
        end
    end
end
