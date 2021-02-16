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
    {
      email: 'learl@adcogov.org',
      first_name: 'Heather',
      last_name: 'McClure',
      password: 'bosmer',
      password_confirmation: 'bosmer',
    },
  ])

  motels = Motel.create!([
    {
      name: 'Quality Inn Denver Westminster',
      address: {
        street: '8500 Turnpike Dr',
        city:'Westminster',
        state: 'CO', 
        ip: 80030
      },
      phone: '+13034283333'
    },
    {
      name: 'Comfort Inn & Suites Denver Northeast Brighton',
      address: {
        street: '2180 South Medical Center Dr', 
        city: 'Brighton',
        state: 'CO',
        zip: 80601
      },
      phone: '+17206851500'
    }
  ])

  motel_users = User.create!([
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
      email_address: Faker::Internet.email,
    )
    clients << client
  end

  20.times do
    IncidentReport.create!(
      client: clients.sample,
      reporter_id: motel_users.sample.id,
      occurred_at: Faker::Date.between(from: 60.days.ago, to: Date.today),
      description: Faker::Quote.jack_handey,
    )
  end
end
