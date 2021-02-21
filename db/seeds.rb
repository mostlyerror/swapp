# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do |t|

  User.create([
    {
      email: 'bpoon@codeforamerica.org',
      first_name: 'Ben',
      last_name: 'Poon',
      password: 'password',
      password_confirmation: 'password',
      admin: true,
    },
    {
      email: 'ftang@codeforamerica.org',
      first_name: 'Fiona',
      last_name: 'Tang',
      password: 'password',
      password_confirmation: 'password',
      admin: true,
    },
    {
      email: 'bjohnson@codeforamerica.org',
      first_name: 'Brandon',
      last_name: 'Johnson',
      password: 'password',
      password_confirmation: 'password',
      admin: true,
    },
    {
      email: 'ashleydunn@almosthome.org',
      first_name: 'Ashley',
      last_name: 'Dunn',
      password: 'password',
      password_confirmation: 'password',
      admin: true,
    },
    {
      email: "learl@adcogov.org",
      first_name: "Lindsey",
      last_name: "Earl",
      password: "password",
      password_confirmation: "password",
      admin: true,
    }
  ])

  intake_users = User.create([
    {
      email: 'hmcclure@adcogov.org',
      first_name: 'Heather',
      last_name: 'McClure',
      password: 'bosmer',
      password_confirmation: 'bosmer',
    },
  ])

  motels = Motel.create!([
    {
      name: 'City Inn',
      address: {
        street: '7151 Federal Boulevard', 
        city: 'Westminster',
        state: 'CO',
        zip: 80030
      },
      phone: '+13034308700'
    },
    {
      name: 'Comfort Inn-Denver Central',
      address: {
        street: '401 E. 58th Ave', 
        city: 'Denver',
        state: 'CO',
        zip: 80216
      },
      phone: '+13032971717'
    },
    {
      name: 'HomeTowne Studios',
      address: {
        street: '8750 Grant St', 
        city: 'Thornton',
        state: 'CO',
        zip: 80229
      },
      phone: '+13034304474'
    },
    {
      name: 'Quality Inn',
      address: {
        street: '15150 Brighton Rd', 
        city: 'Brighton',
        state: 'CO',
        zip: 80601
      },
      phone: '+13036541400'
    }
  ])

  motel_users = User.create!([
    {
      email: 'charles@cityinn.com',
      first_name: 'Charles',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
    },
    {
      email: 'carol@comfortinn.com',
      first_name: 'Carol',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
    },
    {
      email: 'harriet@hometownestudios.com',
      first_name: 'Harriett',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
    },
    {
      email: 'quincey@qualityinn.com',
      first_name: 'Quincey',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
    }
  ])

  clients = []
  50.times do
    client = Client.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      date_of_birth: Faker::Date.birthday,
      gender: Client::GENDER.sample,
      race: Client::RACE.sample,
      ethnicity: Client::ETHNICITY.sample,
      phone_number: Faker::PhoneNumber.cell_phone,
      email: Faker::Internet.email,
    )
    clients << client
  end

  20.times do
    IncidentReport.create!(
      client: clients.sample,
      reporter_id: motel_users.sample.id,
      occurred_at: Faker::Date.between(from: 60.days.ago, to: Date.current),
      description: Faker::Quote.jack_handey,
    )
  end
end
