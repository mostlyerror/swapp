filename = Rails.root.join("intakes.csv")
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
  @swap_periods = nil
  swaps_start = Swap.count
  clients_start = Client.count
  intakes_start = Intake.count
  short_intakes_start = ShortIntake.count
  vouchers_start = Voucher.count

  Swap.transaction do
    @swap_periods = [
      ['2020-10-26', '2020-10-27'],
      ['2020-11-08', '2020-11-12'],
      ['2020-11-23', '2020-11-29'],
      ['2020-12-01', '2020-12-03'],
      ['2020-12-10', '2020-12-18'],
      ['2020-12-22', '2020-12-23'],
      ['2020-12-26', '2021-01-01'],
      ['2021-01-05', '2021-01-06'],
      ['2021-01-08', '2021-01-12'],
      ['2021-01-16', '2021-01-18'],
      ['2021-01-23', '2021-01-27'],
      ['2021-02-02', '2021-02-19'],
      ['2021-02-24', '2021-03-05']
    ]

    @swap_periods.each do |(start_date, end_date)|
      Swap.create!(start_date: start_date.to_date, end_date: end_date.to_date)
    end
  end

  user = User.first_or_create(email: "swapp@codeforamerica.org")


  hotels = Hotel.all.reduce({}) do |memo, hotel|
    memo.merge(Hash[hotel.name.parameterize.underscore, hotel.id])
  end

  opts = {
    headers: true,
    header_converters: ->(h) { h&.strip },
    converters: ->(f) { f&.strip }
  }

  CSV.foreach(filename, opts) do |row|
    line += 1

    client_attrs = {
      last_name: row['Last Name'],
      first_name: row['First Name'],
      date_of_birth: parse_dob(row['DOB']),
      phone_number: parse_phone_number(row['Phone']),
      gender: parse_gender(row['Gender']),
      email: parse_email(row['Email']),
      ethnicity: row['Ethnicity']
    }

    if client_attrs[:date_of_birth].blank?
      client_attrs[:date_of_birth] = "1600-01-01".to_date
    end

    client = Client.where("lower(last_name) = ? and lower(first_name) = ? and date_of_birth = ?",
        client_attrs[:last_name].downcase,
        client_attrs[:first_name].downcase,
        client_attrs[:date_of_birth].to_s
      ).first

    client ||= Client.new(client_attrs)
    client.save
    
    if client.errors.any?
      ap row
      ap client.errors
      ap client
      gets
    end

    intake_attrs = {
      user: user,

      client: client,
      homelessness_first_time:
        "Is this the first time you have been homeless?",
      how_long_this_time:
        "How long have you been homeless this time?",
      episodes_last_three_years_fewer_than_four_times:
        "Including this time, how many separate times have you stayed in shelters or on the streets in the past 3 years?",
      total_how_long_shelters_or_streets:
        "In total, how long did you stay in shelters or on the streets those times?",
      are_you_working:
        "Are you working?",
      armed_forces:
        "Have you ever served in the US Armed Forces (Army, Navy, Air Force, Marines or Coast Guard)?",
      active_duty:
        "Were you ever called into active duty as a member of the National Guard or as a Reservist?",
      substance_abuse:
        "Do you have any Substance Abuse Issues?",
      chronic_health_condition:
        "Do you have a Chronic Health Condition?",
      mental_health_disability:
        "Do you have a Mental Health disability?",
      physical_disability:
        "Do you have a Physical Disability?",
      developmental_disability:
        "Do you have a Developmental Disability?",
      fleeing_domestic_violence:
        "Are you experiencing homelessness because you are fleeing Domestic
        Violence, Sexual Assault or Stalking?",
      last_permanent_residence_county:
        "County of Last Permanent Residence:"
    }

    intake = Intake.create(intake_attrs)

    if intake.errors.any?
      ap row
      ap intake.errors
      ap intake
      gets
    end

    short_intake_attrs = {
      user: user,
      client: client,
      where_did_you_sleep_last_night:
        "Where did you sleep last night?",
      what_city_did_you_sleep_in_last_night:
        "City and State of Last Permanent Residence:",
      why_not_shelter:
        "What is the reason you have not accessed shelter?",
      bus_pass:
        "Bus Pass",
      king_soopers_card:
        "King Soopers Card",
      family_members: {},
      household_composition_changed: nil
    }

    short_intake = ShortIntake.create(short_intake_attrs)

    if short_intake.errors.any?
      ap row
      ap short_intake.errors
      ap short_intake
      gets
    end

    hotel_id = hotels.fetch(row['Hotel'].parameterize.underscore)
    date_range = parse_date(row['Date']).compact
    check_in = date_range.first
    check_out = date_range.first + row['# of Nights']&.strip.to_i

    swap = Swap.where("start_date <= ? AND ? <= end_date", check_out, check_in).first

    if !swap
      ap check_in
      ap check_out
      ap @swap_periods
      gets
    end

    timestamp = Time.zone.now

    voucher_attrs = {
      client_id: client.id,
      user_id: user.id,
      hotel_id: hotel_id,
      swap_id: swap.id,
      check_in: check_in,
      check_out: check_out,
      number: row['Voucher #']&.strip,
      num_adults_in_household: row['Number of adults in household']&.strip.to_i,
      num_children_in_household: row['Number of children in household']&.strip.to_i,
      created_at: timestamp,
      updated_at: timestamp
    }

    voucher = Voucher.insert(voucher_attrs)
  end

  puts "Swap start: #{swaps_start}, end: #{Swap.count}"
  puts "Swap start: #{clients_start}, end: #{Client.count}"
  puts "Swap start: #{intakes_start}, end: #{Intake.count}"
  puts "Swap start: #{short_intakes_start}, end: #{ShortIntake.count}"
  puts "Swap start: #{vouchers_start}, end: #{Voucher.count}"
end
