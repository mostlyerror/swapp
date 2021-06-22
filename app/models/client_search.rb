class ClientSearch
    def self.search(search_term)
        ap search_term
        search_term.downcase!
        clients = Client.includes(:incident_reports)
        .where("first_name ILIKE ? or last_name ILIKE ?", "%#{search_term}%", "%#{search_term}%").limit(8)
        clients.map do |c| 
            attrs = c.slice(:id, :first_name, :last_name, :name, :date_of_birth)
            attrs.merge(
                banned: c.banned, 
                red_flag: c.incident_reports.any?,
                flagged_hotels: c.flagged_hotels.pluck(:id, :name)
            )
        end
    end
end
