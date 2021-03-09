ActiveRecord::Base.transaction do |t|
  user_data = [
    {
      email: 'frontdesk@cityinn.com',
      first_name: 'City',
      last_name: 'Inn',
      password: 'password',
      password_confirmation: 'password',
      admin: false,
    },
    {
      email: 'frontdesk@comfortinn.com',
      first_name: 'Comfort',
      last_name: 'Inn Denver',
      password: 'password',
      password_confirmation: 'password',
      admin: false,
    },
    {
      email: 'frontdesk@hometownestudios.com',
      first_name: 'Hometowne',
      last_name: 'Studios',
      password: 'password',
      password_confirmation: 'password',
      admin: false,
    },
    {
      email: 'frontdesk@qualityinn.com',
      first_name: 'Quality',
      last_name: 'Inn',
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
      phone: '+13034308700',
      pet_friendly: false,
    },
    {
      name: 'Comfort Inn Denver',
      address: {
        street: '401 E. 58th Ave', 
        city: 'Denver',
        state: 'CO',
        zip: 80216
      },
      phone: '+13032971717',
      pet_friendly: true
    },
    {
      name: 'HomeTowne Studios',
      address: {
        street: '8750 Grant St', 
        city: 'Thornton',
        state: 'CO',
        zip: 80229
      },
      phone: '+13034304474',
      pet_friendly: false,
    },
    {
      name: 'Quality Inn',
      address: {
        street: '15150 Brighton Rd', 
        city: 'Brighton',
        state: 'CO',
        zip: 80601
      },
      phone: '+13036541400',
      pet_friendly: false,
    }
  ]

  Motel.create! motel_data
end
