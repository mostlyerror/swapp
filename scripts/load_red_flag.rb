IncidentReport.transaction do
  irs_start = IncidentReport.count
  filename = Rails.root.join("red_flag.csv")
  line = 1

  system_user = User.find_by(email: "swapp@codeforamerica.org")
  to_reconcile = []
  @to_ban = []

  opts = {
    headers: true,
    header_converters: ->(h) { h&.strip&.downcase },
    converters: ->(f) { f&.strip&.downcase }
  }

  CSV.foreach(filename, opts) do |row|
    line += 1

    if id = row["client_id"]
      client = Client.find(id)
      @to_ban << {
        client: client,
        reason: row["reason"]
      }
      next
    end

    # handle three name entries, e.g., Josiah Elias Martinez Rivera
    names = row["name"].split(" ")
    last_name = names.last
    first_name = names.first
    dob = row["dob"]

    reason = row["reason"]

    clients = Client.where("lower(last_name) = ? and lower(first_name) = ?",
                           last_name.strip.downcase,
                           first_name.strip.downcase)

    if clients.count == 1
      client = clients.first
      @to_ban << {
        client: client,
        reason: reason
      }
    else
      to_reconcile << [names, dob]
    end
  end

  puts "Reconcile: #{to_reconcile.size}"
  puts to_reconcile.map { |c| c.join("\t") }
  puts "=" * 80

  puts "Ban: #{@to_ban.size}"
  puts "=" * 80

  @to_ban.each do |ban|
    client = ban[:client]
    client.incident_reports.create!(
      reporter: system_user,
      description: ban[:reason]
    )
  end

  puts "irs start: #{irs_start}"
  puts "irs end: #{IncidentReport.count}"
end
