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

  keys = [
    :email, :first_name, :last_name, :admin
  ]

  user_data = [
    ['swapp@codeforamerica.org', 'Swapp', 'User', true],
    ['bpoon@codeforamerica.org', 'Ben', 'Poon', true],
    ['bjohnson@codeforamerica.org', 'Brandon', 'Johnson', true],
    ['ftang@codeforamerica.org', 'Fiona', 'Tang', true],
    ['learl@adcogov.org', 'Lindsey', 'Earl', true],
    ['pdiaz@adcogov.org', 'Paolo', 'Diaz', true],
    ['mcercone@adcogov.org', 'Max', 'Cercone', true],
    ['cjurischk@adcogov.org', 'Courtney', 'Jurischk', true],
    ['mrivera@adcogov.org', 'Matt', 'Rivera', true],
    ['hmcclure@adcogov.org', 'Heather', 'McClure', false],
    ['jschultz@adcogov.org', 'Jason', 'Schultz', true],
    ['ashley@almosthomeonline.org', 'Ashley', 'Dunn', true],
    ['stephanie@almosthomeonline.org', 'Stephanie', 'Beazley', false],
    ['jeanette@almosthomeonline.org', 'Jeanette', 'Causey', false],
    ['nubia@almosthomeonline.org', 'Nubia', 'Saenz', true],
    ['mayra.galaviz@thorntonco.gov', 'Mayra', 'Galaviz', false],
    ['jaylin.stotler@thorntonco.gov', 'Jaylin', 'Stotler', false],
    ['mario.solis-armenta@thorntonco.gov', 'Mario', 'Solis-Armenta', false],
    ['rvenkatesh@northglenn.org', 'Rupa', 'Venkatesh', false],
    ['jhulse@northglenn.org', 'Jessica', 'Hulse', false],
    ['claudia@almosthomeonline.org', 'Claudia', 'Melendez', false]
  ]

  user_data.each do |data|
    first_part = data[1].slice(0, 1)
    last_part = data[2].slice(0, 4)
    whole_together = "#{first_part + last_part}2021".downcase
    passwords = {
      password: whole_together,
      password_confirmation: whole_together
    }
    User.create! keys.zip(data).to_h.merge(passwords)
  end

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
