module MessagesHelper

    def parse_sms(sms)
        if Swap.current
            body = sms[:Body]&.strip&.upcase
            from = sms[:From]
            
            case body

            when "SWAP"
                hotels = Hotel.all.pluck(:id, :name).to_h
                vouchers_today = RoomSupply.vouchers_remaining_today(Swap.current)
                vacancies = vouchers_today.map do |hotel_id, vouchers|
                    "#{hotels[hotel_id]} - #{vouchers}\n"
                end
                
                return "Today's Availability (#{Date.current}):\n\n#{vacancies.join()}" 

            else
                return "Thank you for contacting the Swap hotline. The only available command is SWAP.\n\nPlease try again or call (720) 523-6646."
            end
        else
            return "Swap is not currently active. Please check your activation email for details or call (720) 523-6646."
        end
    end
end
