ActiveRecord::Base.transaction do |t|
  race_data = [
    {name: "American Indian or Alaskan Native"},
    {name: "Asian"},
    {name: "Black or African American"},
    {name: "Native Hawaiian or other Pacific Islander"},
    {name: "White"}
  ]
  Race.create(race_data)

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
      name: 'Comfort Inn-Denver Central',
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
