reload!
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

def parse_dob(val)
  parse_date(val).first
end

def parse_phone_number(val)
  return nil if val.blank?
  phone = val.to_s.strip
  return val if Phonelib.valid?(val)
  nil
end

def parse_email(val)
  return nil if val.blank?
  val =~ Devise.email_regexp && val
end

def parse_gender(val)
  return nil if val.blank?
  gender = val.to_s.strip
  gender[0] = gender[0].capitalize
  gender
end

def parse_race(val)
  return nil if val.blank?
  race = val.to_s&.strip
end

ActiveRecord::Base.transaction do
  CSV.foreach(filename, opts) do |row|
    line += 1

    attrs = {
      last_name: row['Last Name'],
      first_name: row['First Name'],
      date_of_birth: parse_dob(row['DOB']),
      phone_number_raw: row['Phone'],
      phone_number: parse_phone_number(row['Phone']),
      gender: parse_gender(row['Gender']),
      email_raw: row['Email'],
      email: parse_email(row['Email']),
      ethnicity: row['Ethnicity']
    }
    client = Client.create(attrs)

    if client.errors.any?
      ap row
      ap client.errors
      ap client
      gets
    end
  end
  raise :finished
end
