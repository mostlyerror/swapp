module DatesHelper
  def humanize_date(dt)
    return "" if dt.nil?
    dt.strftime("%A, %b #{dt.day.ordinalize}")
  end

  def humanize_date_with_year(dt)
    return "" if dt.nil?
    dt.strftime("%A, %b #{dt.day.ordinalize}, %Y")
  end

  def humanize_date_short(dt)
    return "" if dt.nil?
    dt.strftime("%a, %b #{dt.day.ordinalize}")
  end
end
