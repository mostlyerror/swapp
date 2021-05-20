module DatesHelper
  def humanize_date(dt)
    dt.strftime("%A, %b #{dt.day.ordinalize}")
  end

  def humanize_date_with_year(dt)
    dt.strftime("%A, %b #{dt.day.ordinalize}, %Y")
  end

  def humanize_date_short(dt)
    dt.strftime("%a, %b #{dt.day.ordinalize}")
  end
end
