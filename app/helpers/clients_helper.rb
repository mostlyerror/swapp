module ClientsHelper
  def formatted_date(dt)
    dt.to_date.to_formatted_s(:date_of_birth)
  end

  def button_class(disabled)
    disabled ?
      "bg-gray-100 hover:none text-gray-500 text-center px-4 md:px-8 py-1 md:py-2 rounded-lg shadow cursor-not-allowed" :
      "bg-indigo-600 hover:bg-indigo-700 text-white text-center px-4 md:px-8 py-1 md:py-2 rounded-lg shadow"
  end
end
