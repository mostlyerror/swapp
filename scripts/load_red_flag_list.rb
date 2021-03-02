reload!
filename = Rails.root.join("red_flag_list.csv")
opts = {headers: true}
line = 1


ActiveRecord::Base.transaction do
  user = User.find_by(email: "swapp@codeforamerica.org")
  to_reconcile = []
  to_ban = []

  CSV.foreach(filename, opts) do |row|
    line += 1

    number = row['number']
    # handle three name entries, e.g., Josiah Elias Martinez Rivera
    names = row['name'].split(' ')
    last_name = names.last
    first_name = names.first

    hotel = row['hotel']
    reason = row['reason']

    clients = Client.where("lower(last_name) = ? and lower(first_name) = ?", 
      last_name.strip.downcase, 
      first_name.strip.downcase)
    
    # for each match
    # if there's multiple clients with that name, we can't do shit, because we can't disambiguate 
    # and if we don't find them, the same
    if clients.count == 1
      client = clients.first
      to_ban << [number, names, client.name]
    else
      to_reconcile << [number, names]
    end


    # "ban"?
    # pretend IR's don't exist (client, user_id, text)
    #
    # client, motel_id, reporter_id, program_wide (bool)
    # check for program_wide, 
    # if true we're good
    # if false, use the motel

    # if incident_report.errors.any?
    #   ap row
    #   ap incident_report
    #   ap incident_report.errors
    #   gets
    # end
  end

  # puts "#{IncidentReport.count} reports"

  puts "Reconcile: #{to_reconcile.size}"
  puts to_reconcile.map {|c| c.join("\t")}
  puts "=" * 80

  puts "Ban: #{to_ban.size}"
  puts to_ban.map {|c| c.join("\t")}

  raise 'finished'
end
