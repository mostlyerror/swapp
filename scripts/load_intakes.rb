filename = Rails.root.join("tmp", "intakes.csv")
opts = {headers: true}
line = 1

CSV.foreach(filename, opts) do |row|
  line += 1
  date_str = row['Date']

  d1, d2 = date_str.to_s.split("-")
  d1, d2 = [d1, d2].compact.map do |d|
    Date.parse(d, year: 2020)
  rescue Date::Error
    begin 
      Date.strptime(d, "%m/%d/%Y")
    rescue Date::Error
      # 2nd format mm/dd/yyyy failed
    end
  end

  puts "row['Date']: #{date_str} d1:#{d1.to_s.rjust(8)} d2:#{d2}"
rescue
  puts "line in sheet: #{line}"
  ap date_str
  raise
end
