module DatesHelper
  def humanize_date(dt)
    dt.strftime("%A, %b #{dt.day.ordinalize}")
  end

<<<<<<< HEAD
=======
  def humanize_date_with_year(dt)
    dt.strftime("%A, %b #{dt.day.ordinalize}, %Y")
  end

>>>>>>> 81f1f12cb6be2f93e4bdb0be295d2865f63f0c8e
  def humanize_date_short(dt)
    dt.strftime("%a, %b #{dt.day.ordinalize}")
  end
end
