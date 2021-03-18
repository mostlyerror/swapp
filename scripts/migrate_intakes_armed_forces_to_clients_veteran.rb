Client.transaction do
  start = Intake.pluck(:armed_forces).tally
  intakes = Intake.includes(:client)
    .where.not(armed_forces: nil)
    .find_each do |intake|
      next if intake.armed_forces
      client = intake.client
      client.veteran = intake.armed_forces
      client.save!(validate: false)
    end
  ap "before"
  ap start
  ap "after"
  ap Client.pluck(:veteran).tally
end
