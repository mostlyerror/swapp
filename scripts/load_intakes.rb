filename = Rails.root.join("intakes.csv")
opts = {headers: true}
line = 1

formats = [
  "%m/%d",    # m_d_no_year_slash
  "%m-%d",    # m_d_no_year_dash
  "%m/%d/%Y", # m_d_yy_slash
  "%m-%d-%Y", # m_d_yy_dash
  "%d-%b",    # d_b_no_year_dash 
  "%d/%b",    # d_b_no_year_slash
]

CSV.foreach(filename, opts) do |row|
  line += 1
  date_str = row['Date'].to_s
  d1, d2 = date_str.to_s.split("-")

  d1, d2 = [d1, d2].compact.map do |d|
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

  puts "date_str: #{date_str.ljust(16)} d1: #{d1.to_s.ljust(16)} d2: #{d2}"
rescue
  puts "line in sheet: #{line}"
  ap date_str
  raise
end
