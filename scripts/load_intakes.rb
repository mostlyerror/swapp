filename = Rails.root.join("intakes.csv")
opts = {headers: true}
line = 1

def parse_date(val)
  formats = [
    "%m/%d",    # m_d_no_year_slash
    "%m-%d",    # m_d_no_year_dash
    "%m/%d/%Y", # m_d_yy_slash
    "%m-%d-%Y", # m_d_yy_dash
    "%d-%b",    # d_b_no_year_dash 
    "%d/%b",    # d_b_no_year_slash
  ]
  d1, d2 = val.to_s.strip.split("-")
  [d1, d2].compact.map do |d|
    date = nil
    formats.each do |fmt|
      date = Date.strptime(d, fmt)
      year = date.month > 6 ? 2020 : 2021
      date = Date.new(year, date.month, date.day)
      break
    rescue Date::Error
      next
    end
    date
  end
end

def parse_phone_number(val)
  phone = val.to_s.strip
  return val if Phonelib.valid?(val)
  nil
end

def parse_gender(val)
  return nil if val.nil?
  gender = val.to_s.strip
  gender[0] = gender[0].capitalize
  gender
end

CSV.foreach(filename, opts) do |row|
  line += 1
  date_str = row['Date'].to_s

  attrs = {
    last_name: row['Last Name'],
    first_name: row['First Name'],
    date_of_birth: parse_date(row['DOB']),
    phone_number_raw: row['Phone'],
    phone_number: parse_phone_number(row['Phone']),
    gender: parse_gender(row['Gender']),
    email: row['Email'],
    race: row['Race'],
    ethnicity: row['Ethnicity']
  }
  client = Client.new(attrs)
  client.validate
  if client.errors.any?
    ap client.errors
    ap row
    ap client
    gets
  end
end
