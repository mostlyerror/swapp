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
  d1, d2 = val.split("-")
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

CSV.foreach(filename, opts) do |row|
  line += 1
  date_str = row['Date'].to_s
  dates = parse_date(date_str).compact
  puts "line: #{line.to_s.ljust(16)} date_str: #{date_str.ljust(16)} output: #{dates}"
rescue
  puts "line in sheet: #{line}"
  ap date_str
  raise
end
