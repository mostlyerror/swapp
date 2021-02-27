def parse(row)
  row = row.first
  {
    date: parse_date_string(row[:date])
  }
end

# def parse_date_string_debug(date_string, examples)
#   d1, d2 = date_string.split("-")
#   [d1, d2].compact.map {|dt| Date.parse(dt) }
# rescue Date::Error => e
#   begin
#     [d1, d2].compact.map {|dt| Date.strptime(dt, "%m/%d/%Y") }
#   rescue Date::Error => e
#     examples.add(date_string)
#   end
# rescue NoMethodError => e
#   examples.add(date_string)
# end
# unhandled values
#     [0] nil,
#     [1] "VOIDED",
#     [2] "Voided"

def parse_date(date)
  a = ->(dt) { 
    d1, d2 = dt.split("-")
    [d1, d2].compact.map {|d| Date.parse(dt) }
  }

  b = ->(dt) { 
    d1, d2 = dt.split("-")
    [d1, d2].compact.map do |d| 
      Date.strptime(d, "%m/%d/%Y")
    end
  }

  val = nil
  [a, b].each do |func|
    val = func.call(date)
    break if val
  rescue
    next
  end
  val
end

def parse(col, val)
  return {
    :date => parse_date(val)
  }[col]
end

# filename = Rails.root.join("tmp", "intakes-10-2021-02-26.csv")
filename = Rails.root.join("tmp", "intakes.csv")
examples = Set.new
errors = Set.new
SmarterCSV.process(filename, verbose: true) do |row|
  ap parse(:date, row.first[:date])
  # row.first.each do |col, val|
  #   ap parse(col, val)
  # end
end


