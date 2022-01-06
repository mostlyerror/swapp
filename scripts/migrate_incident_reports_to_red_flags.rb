# produce list of everyone that has incident reports

# loop over all existing incident reports
IncidentReport.all.each do |ir|
  RedFlag.create!(client: ir.client, hotel: ir.hotel)
  # create red flag record for client & hotel pair
  # update banned: true
  # ir.client.update(banned: true)
end
