# one time script to create all the identified pilot user accounts

passwords = {
  password: 'password',
  password_confirmation: 'password'
}

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
  ['hmcclure@adcogov.org', 'Heather', 'McClure', true],
  ['jschultz@adcogov.org', 'Jason', 'Schultz', true],
  ['ashley@almosthomeonline.org', 'Ashley', 'Dunn', true],
  ['stephanie@almosthomeonline.org', 'Stephanie', 'Beazley', true],
  ['jeanette@almosthomeonline.org', 'Jeanette', 'Causey', true],
  ['nubia@almosthomeonline.org', 'Nubia', 'Saenz', true],
  ['mayra.galaviz@thorntonco.gov', 'Mayra', 'Galaviz', true],
  ['jaylin.stotler@thorntonco.gov', 'Jaylin', 'Stotler', true],
  ['mario.solis-armenta@thorntonco.gov', 'Mario', 'Solis-Armenta', true],
  ['rvenkatesh@northglenn.org', 'Rupa', 'Venkatesh', true],
  ['jhulse@northglenn.org', 'Jessica', 'Hulse', true],
]

user_data.each do |data|
  User.create! keys.zip(data).to_h.merge(passwords)
end
