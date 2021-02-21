ActiveRecord::Base.transaction do |t|
  user_data = [
    {
      email: 'sudney@cityinn.com',
      first_name: 'Sydney',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
      admin: false,
    },
    {
      email: 'carol@comfortinn.com',
      first_name: 'Carol',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
      admin: false,
    },
    {
      email: 'harriet@hometownestudios.com',
      first_name: 'Harriett',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
      admin: false,
    },
    {
      email: 'quincey@qualityinn.com',
      first_name: 'Quincey',
      last_name: 'Motel',
      password: 'password',
      password_confirmation: 'password',
      admin: false
    }
  ]

  User.create!(user_data)

  motel_data = [
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
  ]

  Motel.create! motel_data
end
