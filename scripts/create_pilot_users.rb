# one time script to create all the identified pilot user accounts

# passwords = {
  # password: 'password',
  # password_confirmation: 'password'
# }

keys = [
  :email, :first_name, :last_name, :admin
]

user_data = [
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
  ['stephanie@almosthomeonline.org', 'Stephanie', 'Beazley', true],
  ['jeanette@almosthomeonline.org', 'Jeanette', 'Causey', true],
  ['nubia@almosthomeonline.org', 'Nubia', 'Saenz', true],
  ['mayra.galaviz@thorntonco.gov', 'Mayra', 'Galaviz', false],
  ['jaylin.stotler@thorntonco.gov', 'Jaylin', 'Stotler', false],
  ['mario.solis-armenta@thorntonco.gov', 'Mario', 'Solis-Armenta', false],
  ['rvenkatesh@northglenn.org', 'Rupa', 'Venkatesh', false],
  ['jhulse@northglenn.org', 'Jessica', 'Hulse', false],
]

user_data.each do |data|
  first_name_part = data[1].slice(0, 3)
  last_name_part = data[2].slice(0, 4)

  passwords = {
    password: '"#{first_name_part + last_name_part}2021".downcase',
    password_confirmation:'"#{first_name_part + last_name_part}2021".downcase'

}

  User.create! keys.zip(data).to_h.merge(passwords)
end
