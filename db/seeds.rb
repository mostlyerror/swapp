ActiveRecord::Base.transaction do |t|
  # hotels
  test_hotel = Hotel.create!(
    name: 'Test Inn (Westminster)',
    address: {
      street: '7151 Federal Boulevard', 
      city: 'Westminster',
      state: 'CO',
      zip: 80030
    },
    phone: '+13034308700',
    pet_friendly: false
  )

  # create hotel user
  test_hotel_user = User.create!(
    email: 'frontdesk@testinn.com',
    first_name: 'Test',
    last_name: 'Inn',
    password: 'password',
    password_confirmation: 'password',
    hotel_user: true,
  )

  HotelUser.create!(
    user: test_hotel_user,
    hotel: test_hotel,
  )

  # create hotel contacts
  test_hotel.contacts.create!(
    first_name: "Christopher",
    last_name: "Contact",
    phone: "1231234567",
    title: "General Manager"
  )

  # create admin and intake users
  [
    {
      first_name: "Swapp",
      last_name: "User",
      email: "swapp@codeforamerica.org",
      admin_user: true,
      password: "password",
      password_confirmation: "password"
    },
    {
      first_name: "Ben",
      last_name: "Poon",
      email: "bpoon@codeforamerica.org",
      admin_user: true,
      password: "password",
      password_confirmation: "password"
    },
    {
      first_name: "Intake",
      last_name: "User",
      email: "intakeuser@adcogov.org",
      intake_user: true,
      password: "password",
      password_confirmation: "password"
    }
  ].each do |data|
    User.create!(data)
  end
end
