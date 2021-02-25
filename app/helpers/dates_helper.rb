module DatesHelper
  def humanize_date(dt)
    dt.strftime("%A, %b #{dt.day.ordinalize}")
  end
end
