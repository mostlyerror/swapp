module ClientsHelper
  def formatted_date(dt)
    dt.to_date.to_formatted_s(:date_of_birth)
  end
end
