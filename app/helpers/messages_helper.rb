module MessagesHelper

    def parse_sms(sms)
         
        body = sms[:Body]&.strip&.upcase
        from = sms[:From]

        case body

        when "SWAP"
            return "You said SWAP"
        
        when "ACTIVATE"
            return "You messaged #{body}"
        else
            return "Sorry, I didn't get that. The available commands are SWAP and ACTIVATE. Please try again."
    end
end
end
