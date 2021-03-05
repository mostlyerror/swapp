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
  formats = [
    "%m/%d/%Y", # m_d_yy_slash
    "%m-%d-%Y"  # m_d_yy_dash
  ]
  date = date_str = val.to_s.strip
  formats.each do |fmt|
    date = Date.strptime(date_str, fmt)
    break
  rescue Date::Error
    next
  end
  date
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
  user = User.find_by(email: "swapp@codeforamerica.org")
  
  CSV.foreach(filename, opts) do |row|
    line += 1

    client_attrs = {
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

    client = Client.where("lower(last_name) = ? and lower(first_name) = ? and date_of_birth = ?", 
        client_attrs[:last_name].downcase, 
        client_attrs[:first_name].downcase, 
        client_attrs[:date_of_birth]
      ).first

    client ||= Client.new(client_attrs)

    if client.errors.any?
      ap row
      ap client.errors
      ap client
      gets
    end

    intake_attrs = {
      user: user,
      survey: {
        king_soopers_card: row['King Soopers Card']&.strip,
        bus_pass: row['Bus Pass']&.strip,
        homelessness_first_time: row['Is this the first time you have been homeless?']&.strip,
        homelessness_how_long_this_time: row['How long have you been homeless this time?']&.strip,
        homelessness_episodes_last_three_years: row['Including this time, how many separate times have you stayed in shelters or on the streets in the past 3 years?']&.strip,
        homelessness_episodes_how_long: row['In total, how long did you stay in shelters or on the streets those times?']&.strip,
        how_long_living_in_this_community: row['How long have you been living in this community?']&.strip,
        where_did_you_sleep_last_night: row['Where did you sleep last night?']&.strip,
        why_not_shelter: row['What is the reason you have not accessed shelter?']&.strip,
        are_you_working: row['Are you working?']&.strip,
        active_duty: row['Were you ever called into active duty as a member of the National Guard or as a Reservist?']&.strip,
        armed_forces: row['Have you ever served in the US Armed Forces (Army, Navy, Air Force, Marines or Coast Guard)?']&.strip,
        substance_abuse: row['Do you have any Substance Abuse Issues?']&.strip,
        substance_abuse_impairment: row['impair_substance']&.strip,
        chronic_health_condition: row['Do you have a Chronic Health Condition?']&.strip,
        chronic_health_condition_impairment: row['impair_chronic_health_condition']&.strip,
        mental_health_disability: row['Do you have a Mental Health disability?']&.strip,
        mental_health_disability_impairment: row['impair_mental_health']&.strip,
        physical_disability: row['Do you have a Physical Disability?']&.strip,
        physical_disability_impairment: row['impair_physical_disability']&.strip,
        developmental_disability: row['Do you have a Developmental Disability?']&.strip,
        developmental_disability_impairment: row['impair_developmental_disability']&.strip,
        fleeing_domestic_violence: row['Are you experiencing homelessness because you are fleeing Domestic Violence, Sexual Assault or Stalking?']&.strip,
        num_adults_household: row['Number of adults in household']&.strip,
        num_children_household: row['Number of children in household']&.strip,
        last_permanent_residence_city_and_state: row['City and State of Last Permanent Residence:']&.strip,
        last_permanent_residence_county: row['County of Last Permanent Residence:']&.strip
      },
      client: client
    }

    intake = Intake.create(intake_attrs)

    if intake.errors.any?
      ap row
      ap intake.errors
      ap intake
      gets
    end
  end
  puts "#{Client.count} clients"
  puts "#{Intake.count} intakes"
end
