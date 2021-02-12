# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([
  {
    email: 'bpoon@codeforamerica.org',
    password: 'password',
    password_confirmation: 'password',
    admin: true,
  },
  {
    email: 'ftang@codeforamerica.org',
    password: 'password',
    password_confirmation: 'password',
    admin: true,
  },
  {
    email: 'bjohnson@codeforamerica.org',
    password: 'password',
    password_confirmation: 'password',
    admin: true,
  },
  {
    email: 'heather@adcogov.org',
    password: 'password',
    password_confirmation: 'password',
  }
])

100.times do
  client = Client.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    date_of_birth: Faker::Date.birthday,
    gender: Faker::Gender.type
  )

  client.incident_reports.create(
    occurred_at: Faker::Date.between(from: 60.days.ago, to: Date.today),
    description: Faker::Quote.jack_handey
  )
end
