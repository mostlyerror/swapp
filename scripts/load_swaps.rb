reload!
filename = Rails.root.join("intakes.csv")
opts = {headers: true}
line = 1

def parse_date(val)
  formats = [
    "%m-%d",    # m_d_no_year_dash
    "%m/%d/%Y", # m_d_yy_slash
    "%m-%d-%Y", # m_d_yy_dash
    "%m/%d",    # m_d_no_year_slash
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

def combine_ranges(r1, r2)
end

ActiveRecord::Base.transaction do
  swaps_start_count = Swap.count
  # system_user = User.find_by(email: "swapp@codeforamerica.org")
  
  swaps = []
  CSV.foreach(filename, opts) do |row|
    line += 1
    
    d1, d2 = parse_date(row['Date'])
    r = d2.present? ? d1..d2 : d1
    swaps.find {|sw| (sw.first)..(sw.last).overlaps? r }

    # pass #1: 
    # make all 'unique' ranges from dates,
    # combine when overlapping true
    #
    # pass #2:
    # combine 'adjacent' ranges into single swaps
    
    # tests:
    # no overlapping swaps
    # no adjacent swaps
    #   - all swaps have 1day+ buffer
    #
    # also run Swap model validations, they should
    # match up with these tests^
  end

  puts "#{Swap.count} swaps (start)"
  puts "#{swaps_start_count} swaps (end)"
end
