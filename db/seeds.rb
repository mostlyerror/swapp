ActiveRecord::Base.transaction do |t|
  # hotels
  test_hotel =
    Hotel.find_or_create_by(
      name: 'Test Inn (Westminster)',
      address: {
        street: '7151 Federal Boulevard',
        city: 'Westminster',
        state: 'CO',
        zip: 80_030,
      },
      phone: '+13034308700',
      pet_friendly: false,
    )

  # create hotel user
  test_hotel_user =
    User.find_or_create_by(
      email: 'frontdesk@testinn.com',
      first_name: 'Test',
      last_name: 'Inn',
      hotel_user: true,
    ) do |user|
      user.password = 'password'
      user.password_confirmation = 'password'
      # user.confirmed_at = Time.current
    end

  HotelUser.find_or_create_by(user: test_hotel_user, hotel: test_hotel)

  # create hotel contacts
  test_hotel.contacts.find_or_create_by(
    first_name: 'Christopher',
    last_name: 'Contact',
    phone: '1231234567',
    title: 'General Manager',
  )

  # create admin and intake users
  [
    {
      first_name: 'Swapp',
      last_name: 'User',
      email: 'swapp@codeforamerica.org',
      admin_user: true,
    },
    {
      first_name: 'Ben',
      last_name: 'Poon',
      email: 'bpoon@codeforamerica.org',
      admin_user: true,
    },
    {
      first_name: 'Jacob',
      last_name: 'Valore',
      email: 'jvalore@adcogov.org',
      admin_user: true,
    },
    {
      first_name: 'Intake',
      last_name: 'User',
      email: 'intakeuser@adcogov.org',
      intake_user: true,
    },
  ].each do |data|
    User.find_or_create_by(data) do |user|
      user.password = 'password'
      user.password_confirmation = 'password'
      # user.confirmed_at = Time.current
    end
  end
end
